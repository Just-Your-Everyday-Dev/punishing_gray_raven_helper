import  Document from 'mongoose';

export interface ICharacter extends Mongoose {
    name?: string;
    wikiUrl?: string;
    thumbnailUrl?: string;
    portraitUrl?: string;
    stats?: IStats;
    bio?: IBio;
    information?: string;
    specialty?: string;
    element?: string;
    rank?: string;
    class?: string;
    weaponType?: string;
    faction?: string;
    optimalWeapon?: IOptimalWeapon;
    optimalCub?: IOptimalCub;
    memoryBuild?: string;
    memoryResonance?: string;
    weaponResonances?: Array<IWeaponResonance>;
    characterLeap?: Array<ICharacterLeap>;

}

interface IStats {
    hp: number;
    def: number;
    atk: number;
    crit: number
}

interface IBio {
    activationDate: string;
    height: string;
    weight: string;
    vitalFluidType: string;
    mentalAge: string;
}

interface IOptimalWeapon {
    name: string;
    description: string
}

interface IOptimalCub {
    name: string;
    description: string
}

interface IWeaponResonance {
    title: string;
    description: string;
}

interface ICharacterLeap {
    title: string;
    description: string;
}