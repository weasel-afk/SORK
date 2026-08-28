# SORK
This is a roblox game, that uses Azul to sync work done in VSC to roblox studio.
It's very basic so far.. not much done yet
I wanted to keep this opwn just incase somebody was looking for coding examples, like some new roblox studio developers look into toolbox assets.
# default.project.json
default.project.json is a rojo related file, that shows where in this repo relates to where in the roblox explorer.
# Hahaha! Just kidding
Nope, now I use azul! I mainly edit in Roblox studio, so rojo doesn't work from studio to vscode:(
You can also see everything in explorer, but maybe not in the easiest way.
# So what is this?
Well, like it's really just meant to be so if anyone wants to find some code to use they can
I don't care enough to make a guide on how to use this, you can find it yourself.
You just need azul and Rokit, although its just wally
# Here is the Ascii layout I made with copilot just to make it easier :)
┌─────────────────────────────────────────────────────────────────┐
│                    SORK - ROBLOX GAME FLOW                      │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 1. PLAYER INITIALIZATION                                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Player Joins Game                                              │
│       │                                                         │
│       ├─→ Assign to "lobby" Team                               │
│       │                                                         │
│       └─→ Create leaderstats Folder                            │
│           └─→ Initialize Coins = 1000                          │
│                                                                  │
│  Load Player Data from DataStore                               │
│       │                                                         │
│       ├─→ Fetch stored Coins & Owned items                     │
│       └─→ Update leaderstats.Coins                             │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 2. CHARACTER SELECTION                                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Player chooses character via UI                               │
│       │                                                         │
│       └─→ CharSelect RemoteEvent fired                         │
│           └─→ CharacterManager.ChangeChar()                    │
│               └─→ Applies chosen character to player           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 3. GAME LOOP & ROUND MANAGEMENT                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Main Server Loop (1 sec ticks)                                │
│       │                                                         │
│       ├─→ Broadcast TimeToStart to all clients                 │
│       │                                                         │
│       ├─→ Check if TimeToStart reached                         │
│       │                                                         │
│       │   IF TimeToStart <= current time:                      │
│       │   │                                                    │
│       │   ├─ IF roundManager.Status == 0 (stopped):           │
│       │   │  └─ roundManager.startRound()                      │
│       │   │     └─ Set next timeout to 30 seconds              │
│       │   │                                                    │
│       │   └─ ELSE (round running):                            │
│       │      └─ roundManager.stopRound()                       │
│       │         └─ Set next timeout to 20 seconds              │
│       │                                                         │
│       └─→ ELSE (waiting for start):                           │
│           └─ Randomly change status (25% chance)              │
│              └─ Create variety in round conditions              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 4. GAMEPLAY ELEMENTS                                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ World Environment                                        │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │ • Lobby (spawn area)                                     │  │
│  │ • Door (navigation)                                      │  │
│  │ • NPC Shop (interact to buy items)                       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Player Inventory (ReplicatedStorage/tools)               │  │
│  ├──────────────────────────────────────────────────────────┤  │
│  │ • ClassicSword (weapon)                                  │  │
│  │ • Soda (consumable)                                      │  │
│  │ • CoinPads (collect coins)                               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 5. DATA PERSISTENCE                                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Player Data (DataStore)                                       │
│       │                                                         │
│       ├─→ Coins (currency amount)                              │
│       │                                                         │
│       └─→ Owned (items purchased from shop)                    │
│                                                                  │
│  Save triggers:                                                │
│       ├─→ Player leaves game                                   │
│       └─→ Server shutting down                                 │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│ 6. SYSTEMS & MODULES                                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  CharacterManager    → Handles character swaps                  │
│  RoundManager        → Controls game round states (0-4)         │
│  ShopManager         → Manages NPC shop & purchases             │
│  Verify              → Validation utility                       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘