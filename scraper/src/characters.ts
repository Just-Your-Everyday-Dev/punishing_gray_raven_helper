import axios from 'axios';
import * as cheerio from 'cheerio';
import ImageKit from 'imagekit';
import mongoose, {Schema, Document} from 'mongoose';
import * as dotenv from 'dotenv';
import * as path from 'path';
import {ICharacter} from '../../shared/models/character_model';
import {connectDB} from '../../shared/db_connection'
dotenv.config({path: path.resolve(__dirname, '../.env')});

const imageKit = new ImageKit({
    publicKey: process.env.IMAGE_KIT_PUBLIC_KEY!,
    urlEndpoint: process.env.IMAGE_KIT_URL_ENDPOINT!,
    privateKey: process.env.IMAGE_KIT_PRIVATE_KEY!
});



const CharacterSchema = new Schema<ICharacter>({
    name: {type: String, required: true, unique: true},
    wikiUrl: String,
    thumbnailUrl: String,
    portraitUrl: String,
    stats: {
        hp: Number,
        def: Number,
        atk: Number,
        crit: Number,
    },
    bio: {
        activationDate: String,
        height: String,
        weight: String,
        vitalFluidType: String,
        mentalAge: String,
    },
    information: String,
    specialty: String,
    element: String,
    rank: String,
    class: String,
    weaponType: String,
    faction: String,
    optimalWeapon: {name: String, description: String},
    optimalCub: {name: String, description: String},
    memoryBuild: String,
    memoryResonance: String,
    weaponResonances: [{title: String, description: String}],
    characterLeap: [{title: String, description: String}],
});

const Character = mongoose.model<ICharacter>('Character', CharacterSchema);

const BASE_URL = 'https://grayravens.com';

const uploadToImageKit = async (imageUrl: string, fileName: string, folder: string): Promise<string> => {
    const response = await axios.get(imageUrl, {responseType: 'arraybuffer'});
    const buffer = Buffer.from(response.data);

    const result = await imageKit.upload({
        file: buffer,
        fileName: fileName,
        folder: `/pgr/${folder}`,
    });

    return result.url;
};

const scrapeCharacterList = async (): Promise<{ name: string; wikiUrl: string; thumbnailSrc: string }[]> => {
    const {data} = await axios.get(`${BASE_URL}/wiki/GRAY_RAVENS`);
    const $ = cheerio.load(data);

    const upcomingH2 = $('.mobile-hide .mw-heading').filter((_, el) =>
        $(el).find('h2').text().includes('Upcoming')
    ).first();
    const upcomingIndex = upcomingH2.length ? upcomingH2.index() : Infinity;

    const characters: { name: string; wikiUrl: string; thumbnailSrc: string }[] = [];

    $('.mobile-hide div.character_icon_div').each((_, el) => {
        if ($(el).index() > upcomingIndex) return false;

        const name = $(el).find('a').attr('title')?.trim();
        const wikiPath = $(el).find('a').attr('href');
        const thumbnailSrc = $(el).find('img').attr('src');

        if (name && wikiPath && thumbnailSrc) {
            characters.push({
                name,
                wikiUrl: `${BASE_URL}${wikiPath}`,
                thumbnailSrc: `https:${thumbnailSrc}`,
            });
        }
    });

    console.log(`Found ${characters.length} characters`);
    return characters;
};

const scrapeCharacterDetail = async (name: string, wikiUrl: string, thumbnailSrc: string): Promise<void> => {
    const {data} = await axios.get(wikiUrl);
    const $ = cheerio.load(data);

    // Portrait
    const portraitSrc = $('#infobox-character .left .profile img').attr('src');

    // Stats
    const hp   = parseInt($('#infobox-character .HP #content').text().trim())   || undefined;
    const def  = parseInt($('#infobox-character .DEF #content').text().trim())  || undefined;
    const atk  = parseInt($('#infobox-character .ATK #content').text().trim())  || undefined;
    const crit = parseInt($('#infobox-character .CRIT #content').text().trim()) || undefined;

    // Bio
    const activationDate = $('#infobox-character .activation #content').text().trim()  || undefined;
    const height         = $('#infobox-character .height #content').text().trim()       || undefined;
    const weight         = $('#infobox-character .weight #content').text().trim()       || undefined;
    const vitalFluidType = $('#infobox-character .vital-fluid #content').text().trim()  || undefined;
    const mentalAge      = $('#infobox-character .psychological #content').text().trim()|| undefined;

    // Other infobox fields
    const information = $('#infobox-character .information #content').text().trim() || undefined;
    const specialty   = $('#infobox-character .speciality #content').text().trim()  || undefined;
    const element     = $('#infobox-character .element #content').text().trim()     || undefined;
    const rank        = $('#infobox-character .rank #text').text().trim()           || undefined;
    const charClass   = $('#infobox-character .class #text').text().trim()          || undefined;
    const weaponType  = $('#infobox-character .archetype #text').text().trim()      || undefined;
    const faction     = $('#infobox-character .army #text').text().trim()           || undefined;

    // Optimal weapon and CUB
    const faqs = $('.faq-container .faq');
    const optimalWeapon = {
        name:        $(faqs[0]).find('.question p').text().trim() || undefined,
        description: $(faqs[0]).find('.answer div').text().trim() || undefined,
    };
    const optimalCub = {
        name:        $(faqs[1]).find('.question p').text().trim() || undefined,
        description: $(faqs[1]).find('.answer div').text().trim() || undefined,
    };

    // Memory build
    const memoryBuild = $('table.wikitable#build tr').last().find('td[colspan="3"]').text().trim() || undefined;

    // Memory resonance
    let memoryResonance: string | undefined;
    $('.cb-container').each((_, el) => {
        if ($(el).find('.cb-title div').text().includes('Memory Resonance')) {
            memoryResonance = $(el).find('.cb-text div').text().trim() || undefined;
        }
    });

    // Weapon resonances
    const weaponResonances: { title: string; description: string }[] = [];
    const wrHeader = $('h2 span#Weapon_Resonance').closest('h2');
    wrHeader.nextUntil('h2', '.cb-container').each((_, el) => {
        weaponResonances.push({
            title:       $(el).find('.cb-title div').text().trim(),
            description: $(el).find('.cb-text div').text().trim(),
        });
    });

    // Character leap
    const characterLeap: { title: string; description: string }[] = [];
    const leapHeader = $('h2 span#Character_Leap').closest('h2');
    if (leapHeader.length > 0) {
        leapHeader.nextUntil('h2', 'div.no-history-tabber').first().find('.wds-tab__content').each((_, tab) => {
            characterLeap.push({
                title:       $(tab).find('h3, .tab-title').text().trim(),
                description: $(tab).find('p').text().trim(),
            });
        });
    }

    // Upload images
    const safeName = name.replace(/[: ]/g, '-');
    const thumbnailUrl = await uploadToImageKit(thumbnailSrc, `${safeName}-thumbnail.png`, 'characters/thumbnails');
    const portraitUrl  = portraitSrc
        ? await uploadToImageKit(`https:${portraitSrc}`, `${safeName}-portrait.png`, 'characters/portraits')
        : undefined;

    // Upsert to MongoDB
    await Character.findOneAndUpdate(
        {name},
        {
            name,
            wikiUrl,
            thumbnailUrl,
            portraitUrl,
            stats: {hp, def, atk, crit},
            bio: {activationDate, height, weight, vitalFluidType, mentalAge},
            information,
            specialty,
            element,
            rank,
            class: charClass,
            weaponType,
            faction,
            optimalWeapon,
            optimalCub,
            memoryBuild,
            memoryResonance,
            weaponResonances,
            characterLeap,
        },
        {upsert: true, returnDocument: 'after'}
    );

    console.log(`Saved: ${name}`);
};

const scrapeAllCharacters = async (): Promise<void> => {
    const characters = await scrapeCharacterList();

    for (const character of characters) {
        try {
            await scrapeCharacterDetail(character.name, character.wikiUrl, character.thumbnailSrc);
            await new Promise(resolve => setTimeout(resolve, 10000));
        } catch (err) {
            console.error(`Failed: ${character.name}`, err);
        }
    }

    console.log('Done scraping all characters');
};

const main = async (): Promise<void> => {
    await connectDB();
    await scrapeAllCharacters();
    await mongoose.disconnect();
    console.log('Disconnected from MongoDB');
};

main().catch(console.error);
