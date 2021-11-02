#!mainFile "main.opy"

settings {
    "main": {
        "description": "Mode Version: v1.0\nRecreation of various revealed Overwatch 2 features and community-suggested changes. Developed by Elo Hell Workshops in partnership with the Paris Eternal and SVB.\n\nFull patch notes at workshop.codes/2TEBR. Bug tracker: github.com/CactusPuppy/svb-ow2/issues\n\nInterested in joining the largest Workshop Discord to get help and share your creations? Join workshop.codes/discord.",
        "modeName": "Overwatch 2 Community Patch"
    },
    "lobby": {
        "spectatorSlots": 6,
        "team1Slots": 5,
        "team2Slots": 5
    },
    "gamemodes": {
        "general": {
            "enableSkins": false,
            "enableKillCam": false,
            "respawnTime%": 80
        },
        "control": {
            "enabledMaps": [],
            "roleLimit": "off",
            "enableCompetitiveRules": true
        },
        "escort": {
            "enabledMaps": [],
            "roleLimit": "off",
            "enableCompetitiveRules": true
        },
        "hybrid": {
            "enabledMaps": [],
            "roleLimit": "off",
            "enableCompetitiveRules": true
        },
        "skirmish": {
            "enabledMaps": [
                "workshopIsland"
            ]
        }
    },
    "heroes": {
        "allTeams": {
            "ana": {
                "ability1Cooldown%": 125
            },
            "ashe": {
                "ability1EnemyKb%": 55
            },
            "dva": {
                "secondaryFireMaximumTime%": 200
            },
            "hanzo": {
                "ability3Distance%": 135,
                "ability2Cooldown%": 0,
                "ability2Quantity%": 12
            },
            "junkrat": {
                "ability2Cooldown%": 70
            },
            "echo": {
                "ability1Cooldown%": 116
            },
            "reinhardt": {
                "ability1Cooldown%": 80
            },
            "sigma": {
                "ability1Cooldown%": 75
            },
            "mei": {
                "primaryFireFreezeDuration%": 20,
                "primaryFireFreezeMinimum%": 0,
                "primaryFireFreezeRate%": 0,
                "ultFreezeRate%": 0
            }
        }
    },
    "workshop": {
        "Snowball time between shots": 0.5,
        "Enable Snowball instead of regular right click": false
    }
}
