import mongoose, { Schema } from 'mongoose';
import * as dotenv from 'dotenv';
import * as path from 'path';
import { ICharacter } from '../../../shared/models/character_model';

dotenv.config({ path: path.resolve(__dirname, '../../.env') });

const CharacterSchema = new Schema<ICharacter>({ name: String }, { strict: false });
const Character = mongoose.model<ICharacter>('Character', CharacterSchema);

const run = async () => {
    await mongoose.connect(process.env.MONGO_URI!);

    const characters = await Character.find({}, { name: 1 }).sort({ name: 1 });
    characters.forEach(c => console.log(`${c._id}  ${c.name}`));

    await mongoose.disconnect();
};

run().catch(console.error);