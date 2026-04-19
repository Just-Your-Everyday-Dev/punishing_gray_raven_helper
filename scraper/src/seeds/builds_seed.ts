enum WeaponResoPriority {
    DLT = "Dead Line Timing",
    ML = "Matrix Lightning",
    GA = "Glorious Afterglow"
}

const builds = [
    {
        characterName: "Selena: Pianissimo",
        weaponsResonancePriority: [WeaponResoPriority.DLT, WeaponResoPriority.GA, WeaponResoPriority.ML],
        builds: {
            warzone: [
                {
                    rank: "SS0",
                    type: "Physical",
                    memoriesList: ["Burana", "Burana", "Burana", "Burana", "Cottie", "Cottie"],
                    weaponResonance : ["Cottie", "Cottie"],
                    memoryResonance: {
                        up: "Atk",
                        down: "Ult",
                    },
                },
            ]
        }
    },
    {
        characterName: "Hanying: Solacetune",
        weaponsResonancePriority: [WeaponResoPriority.DLT, WeaponResoPriority.GA, WeaponResoPriority.ML],
        builds: {
            warzone: [
                {
                    rank: "SS0",
                    type: "Physical",
                    memoriesList: ["Chang Wuzi", "Chang Wuzi", "Chang Wuzi", "Chang Wuzi", "Patton", "Patton"],
                    weaponResonance : ["Patton", "Patton"],
                    memoryResonance: {
                        up: "Atk",
                        down: "Ult",
                    },
                },

            ]
        }
    },
    {
        characterName: "Veronica: Aegis",
        weaponsResonancePriority: [WeaponResoPriority.DLT, WeaponResoPriority.GA, WeaponResoPriority.ML],
        builds: {
            warzone: [
                {
                    rank: "SS0",
                    type: "Physical",
                    memoriesList: ["Da Vinci", "Da Vinci", "Keats", "Keats", "Philip II", "Philip II"],
                    weaponResonance : ["Da Vinci", "Da Vinci"],
                    memoryResonance: {
                        up: "Atk",
                        down: "Ult",
                    },
                }

            ]
        }
    },
];