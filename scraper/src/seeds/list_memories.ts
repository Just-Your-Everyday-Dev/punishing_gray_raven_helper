import mongoose, { Schema } from 'mongoose';
import * as dotenv from 'dotenv';
import * as path from 'path';
import { IMemory } from '../../../shared/models/memories_model';

dotenv.config({ path: path.resolve(__dirname, '../../.env') });

const MemorySchema = new Schema<IMemory>({ name: String }, { strict: false });
const Memory = mongoose.model<IMemory>('Memory', MemorySchema);

const run = async () => {
    await mongoose.connect(process.env.MONGO_URI!);

    const memories = await Memory.find({}, { name: 1 }).sort({ name: 1 });
    memories.forEach(m => console.log(`${m._id}  ${m.name}`));

    await mongoose.disconnect();
};

run().catch(console.error);