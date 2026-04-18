import { Document } from 'mongoose';

export  interface IMemory extends Document {
    name: string;
    stars: number;
    stats: {
        hp: number;
        crit: number;
        atk: number;
        def: number;
    };
    setPiece2: string;
    setPiece4: string;
    bustImageUrl: string;
    iconImageUrls: string[];
    portraitImageUrls: string[];
    wikiUrl: string;
}