import express from 'express';
import cors from 'cors';
import * as dotenv  from 'dotenv';
import  {connectDB} from '../../../shared/db_connection';
import characterRoutes from './routes/characters_route';

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());


const PORT = process.env.PORT || 3000;

const start = async () => {
    await connectDB();
    app.listen(PORT, () => {
        console.log(`Server running on ${PORT}`);
    });
};

start().catch(console.error);





