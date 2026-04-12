import axios from 'axios';
import * as cheerio from 'cheerio';
import ImageKit from 'imagekit';
import mongoose, {Schema, Document} from 'mongoose';
import * as dotenv from 'dotenv';
import * as path from 'path';
import {IMemory} from './models/mongoose_model';

dotenv.config({path: path.resolve(__dirname, '../.env')})

const imagekit = new ImageKit({
    publicKey: process.env.IMAGE_KIT_PUBLIC_KEY!,
    privateKey: process.env.IMAGE_KIT_PRIVATE_KEY!,
    urlEndpoint: process.env.IMAGE_KIT_URL_ENDPOINT!,
});

// mongoDB connection

const connectDB = async (): Promise<void> => {
    await mongoose.connect(process.env.MONGO_URI!)
    console.log("MongoDB connected");
};

const MemorySchema = new Schema<IMemory>({
    name: {type: String, required: true, unique: true},
    stars: {type: Number, required: true},
    stats: {
        hp: Number,
        crit: Number,
        atk: Number,
        def: Number,
    },
    setPiece2: String,
    setPiece4: String,
    bustImageUrl: String,
    iconImageUrls: [String],
    portraitImageUrls: [String],
    wikiUrl: String,
});

const Memory = mongoose.model<IMemory>('Memory', MemorySchema);


const uploadToImageKit = async (imageUrl: string, fileName: string, folder: string): Promise<string> => {
    const response = await axios.get(imageUrl, {responseType: 'arraybuffer'});
    const buffer = Buffer.from(response.data);

    const result = await imagekit.upload({
        file: buffer,
        fileName: fileName,
        folder: `/pgr/${folder}`
    });

    return result.url;
}

const scrapeMemoryDetail = async (
    name: string,
    wikiUrl: string,
    bustImageUrl: string,
    stars: number,
): Promise<void> => {
    const {data} = await axios.get(wikiUrl);
    const $ = cheerio.load(data);

    // scrape data
    const cells = $('table.wikitable td');
    const hp = parseInt($(cells[0]).text().trim());
    const crit = parseInt($(cells[1]).text().trim());
    const atk = parseInt($(cells[2]).text().trim());
    const def = parseInt($(cells[3]).text().trim());

    // scrape set bonuses
    const headers = $('span.header');
    const setPiece2 = $(headers[0]).closest('h2').next('p').text().trim();
    const setPiece4 = $(headers[1]).closest('h2').next('p').text().trim();

    // Scrape icon and portrait image URLs
    const iconUrls: string[] = [];
    const portraitUrls: string[] = [];

    $('img').each((_, el) => {
        const src = $(el).attr('src') || '';
        if (src.includes('Icon')) iconUrls.push(`https:${src}`);
        if (src.includes('Portrait')) portraitUrls.push(`https:${src}`);
    });

    // upload bust image
    const bustUrl = await uploadToImageKit(bustImageUrl, `${name}-bust.png`, 'memories/busts');

    // upload icon images
    const uploadedIcons: string[] = [];
    for (let i = 0; i < iconUrls.length; i++) {
        const url = await uploadToImageKit(iconUrls[i], `${name}-icon-${i + 1}.png`, 'memories/icons');
        uploadedIcons.push(url);
    }

    // Upload portrait images
    const uploadedPortraits: string[] = [];
    for (let i = 0; i < portraitUrls.length; i++) {
        const url = await uploadToImageKit(portraitUrls[i], `${name}-portrait-${i + 1}.png`, 'memories/portraits');
        uploadedPortraits.push(url);
    }


    // save to mongoDB
    await Memory.findOneAndUpdate(
        {name},
        {
            name, stars, stats: {hp, crit, atk, def},
            setPiece2,
            setPiece4,
            bustImageUrl: bustUrl,
            iconImageUrls: uploadedIcons,
            portraitImageUrls: uploadedPortraits,
            wikiUrl,
        },
        {upsert: true, returnDocument: 'after'}
    );

    console.log(`Saved: ${name}`);
};

// Scrape the full memories list page
const scrapeAllMemories = async (): Promise<void> => {
    const BASE_URL = 'https://grayravens.com';
    const LIST_URL = `${BASE_URL}/wiki/Memories/Omniframe_Memories`;

    const { data } = await axios.get(LIST_URL);
    const $ = cheerio.load(data);

    const memories: { name: string; wikiUrl: string; bustImageUrl: string; stars: number }[] = [];

    const starRatings = [6, 5, 4, 3, 2];

    $('article.tabber__panel').each((tabIndex, panel) => {
        const stars = starRatings[tabIndex];

        $(panel).find('tr').each((_, row) => {
            const img = $(row).find('img').first();
            const link = $(row).find('td:nth-child(2) a').first();

            const bustImageUrl = img.attr('src');
            const name = link.text().trim();
            const wikiPath = link.attr('href');

            if (name && wikiPath && bustImageUrl) {
                memories.push({
                    name,
                    wikiUrl: `${BASE_URL}${wikiPath}`,
                    bustImageUrl: `https:${bustImageUrl}`,
                    stars,
                });
            }
        });
    });

    console.log(`Found ${memories.length} memories`);

    for (const memory of memories) {
        try {
            await scrapeMemoryDetail(
                memory.name,
                memory.wikiUrl,
                memory.bustImageUrl,
                memory.stars
            );
            // Small delay to avoid hammering the wiki
            await new Promise(resolve => setTimeout(resolve, 1000));
        } catch (err) {
            console.error(`Failed: ${memory.name}`, err);
        }
    }

    console.log('Done scraping all memories');
};

// Entry point
const main = async (): Promise<void> => {
    await connectDB();
    await scrapeAllMemories();
    await mongoose.disconnect();
    console.log('Disconnected from MongoDB');
};

main().catch(console.error);
