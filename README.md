# SORK
This is a roblox game, that uses Azul to sync work done in VSC to roblox studio.
It's very basic so far.. not much done yet
I wanted to keep this opwn just incase somebody was looking for coding examples, like some new roblox studio developers look into toolbox assets.
# BOOM!
Just did huge changes to this branch. Copliot (claude) made knit work with this. Hopefully it works. I haven't tried.
# So what is this?
Well, like it's really just meant to be so if anyone wants to find some code to use they can
I don't care enough to make a guide on how to use this, you can find it yourself.
You just need azul and Rokit, although its just wally
# Here is the Ascii layout I made with copilot just to make it easier :)
(You might have to go to preview)
╔════════════════════════════════════════════════════════════════════════════╗
║                    SORK - ROBLOX GAME ARCHITECTURE                         ║
╚════════════════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────────────────┐
│                          SERVER SCRIPTS                                     │
└─────────────────────────────────────────────────────────────────────────────┘

                         ┌──────────────────┐
                         │   main.server    │◄──── Runs game loop
                         │  (Game Loop)     │     • Manages rounds
                         └────────┬─────────┘     • Broadcasts time
                                  │
                    ┌─────────────┼─────────────┐
                    │             │             │
                    ▼             ▼             ▼
        ┌──────────────────┐  ┌──────────────┐  ┌───────────────┐
        │ dataservih      │  │ CoinPads     │  │shapserver    │
        │ (Data Manager)  │  │(Coin System) │  │(Shop Logic)   │
        └────────┬────────┘  └──────┬───────┘  └───────┬───────┘
                 │                  │                  │
         ┌───────┼──────────────────┼──────────────────┼──────┐
         │       │                  │                  │      │
         │  Loads/Saves Coins  Detects Pads      Handles Purchases
         │  Uses: DataStore    Updates: Coins    Uses: ShopManager
         │  Syncs: ShopManager  Triggers: Coins  Fires: BuyResult
         │                                              Event
         │
         └──────────────────┬──────────────────────────────────┘
                            │
                  ┌─────────┴──────────┐
                  │                    │
                  ▼                    ▼
          ┌──────────────────┐  ┌──────────────────┐
          │  ReplicatedStorage│  │ Shared Modules   │
          │  └─ Shared        │  ├─ CharacterManager│
          │    └─ modules     │  ├─ MapLoader      │
          │      ├─ ShopMgr   │  ├─ roundManager   │
          │      └─ ...       │  └─ ShopManager    │
          │  └─ RE (Events)   │                     │
          │    ├─ timeupdate  │  (Shared by all    │
          │    ├─ BuyItem     │   server/client    │
          │    ├─ BuyResult   │   scripts)         │
          │    ├─ CharSelect  │                     │
          │    └─ ShopProximity                    │
          └──────────────────┘  └──────────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                        WORKSPACE SCRIPTS                                    │
└─────────────────────────────────────────────────────────────────────────────┘

        ┌─────────────────────────────────┐
        │  ShopProximityScript            │
        │  (NPC Shop Proximity Handler)   │
        └────────────────┬────────────────┘
                         │
              Detects when player touches NPC
                         │
                         ▼
          ┌──────────────────────────────┐
          │  Fires ShopProximity Event   │
          │  to ReplicatedStorage.RE     │
          └──────────────────────────────┘
                         │
                         ▼
          ┌──────────────────────────────┐
          │  Network transmission to     │
          │  all connected clients       │
          └──────────────────────────────┘


┌─────────────────────────────────────────────────────────────────────────────┐
│                        CLIENT SCRIPTS (GUI)                                 │
└─────────────────────────────────────────────────────────────────────────────┘

        ┌──────────────────────────────────┐
        │  OpenCloseScript.client          │
        │  (Shop GUI Controller)           │
        └────────────────┬─────────────────┘
                         │
          Listens to ShopProximity event
                         │
                         ▼
          ┌──────────────────────────────┐
          │  When true: Show GUI         │
          │  When false: Hide GUI        │
          └──────────────────────────────┘


╔════════════════════════════════════════════════════════════════════════════╗
║                        DATA FLOW EXAMPLE                                   ║
╚════════════════════════════════════════════════════════════════════════════╝

BUYING AN ITEM:
  
  Client              BuyItem Event           shapserver              ShopManager
  (Player)            (ReplicatedStorage)     (Server Logic)          (Module)
    │                       │                      │                     │
    ├─────────Buy Item─────►│                      │                     │
    │                       ├──────OnServerEvent──►│                     │
    │                       │                      ├──Check Price────────►│
    │                       │                      │                     │
    │                       │                      │◄────Item Data───────┤
    │                       │                      │                     │
    │◄──────────────────────BuyResult Event────────┤                     │
    │                       (Success/Fail)         │                     │


COIN PAD INTERACTION:

  Player touches     ▼  CoinPads Script detects   ▼  leaderstats.Coins
  CoinPad        proximity prompt              updates locally
