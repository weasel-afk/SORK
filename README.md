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
# Here is the Ascii layout of how the game currently flows :)
(You might have to go to preview)
╔════════════════════════════════════════════════════════════════════════════╗
║                    SORK - ROBLOX GAME ARCHITECTURE                         ║
╚════════════════════════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────────────────────────┐
│                          SERVER SCRIPTS (ServerScriptService)               │
└─────────────────────────────────────────────────────────────────────────────┘

                         ┌──────────────────┐
                         │   main.server    │  Runs the game loop
                         │  (Game Loop)     │  • Broadcasts countdown (timeupdate)
                         └────────┬─────────┘  • Starts/stops rounds
                                  │            • Relays killer post-processing
          ┌───────────┬───────────┼──────────────────────────┐
          │           │           │                          │
          ▼           ▼           ▼                          ▼
   ┌────────────┐ ┌─────────┐ ┌───────────┐        ┌──────────────────┐
   │ dataservih │ │CoinPads │ │shapserver │        │ roundManager     │
   │(Data Store)│ │(Coins)  │ │(Buy Logic)│        │ (round flow)     │
   └─────┬──────┘ └────┬────┘ └─────┬─────┘        └────┬─────────────┘
         │             │            │                   │
    Loads/Saves    Proximity    BuyItem event      startRound/stopRound/
    Coins+Owned    prompts +/−  → checks price    changeStatus (Status:
    via DataStore  50 coins     via ShopManager   0 lobby, 1 ingame,
    on join/leave  on pads      → BuyResult       2 door open)
                                                ┌────┴─────────────┐
                                                ▼                  ▼
                                       ┌──────────────┐   ┌──────────────┐
                                       │ MapLoader    │   │CharacterMgr  │
                                       │ clone map to │   │ picks killer │
                                       │ MapPoint,    │   │ (KillerId),  │
                                       │ returns      │   │ applies HP / │
                                       │ RoundSpawn   │   │ stats / tools│
                                       └──────────────┘   └──────────────┘

   PostManager (module): only lets the round's killer trigger
   post-processing effects (checks roundManager.Status + KillerId)

┌─────────────────────────────────────────────────────────────────────────────┐
│                    SHARED MODULES (ReplicatedStorage.Shared.modules)        │
└─────────────────────────────────────────────────────────────────────────────┘

   roundManager ──► CharacterManager ──► ShopManager (ownership check)
        │
        └────────► MapLoader

┌─────────────────────────────────────────────────────────────────────────────┐
│                       REMOTE EVENTS (ReplicatedStorage.RE)                  │
└─────────────────────────────────────────────────────────────────────────────┘

   timeupdate ─► countdown to all clients          BuyItem / BuyResult ─► shop
   roundStart / roundEnd ─► round state to clients CharSelect ─► pick survivor/
   KillerId ─► killer UserId to clients                killer character
   PostRequest / PostProcessing ─► killer-only screen effects
   ShopProximity ─► shop GUI open/close

┌─────────────────────────────────────────────────────────────────────────────┐
│                        WORKSPACE / SERVERSTORAGE SCRIPTS                    │
└─────────────────────────────────────────────────────────────────────────────┘

   npc shop/ShopProximityScript  — touch NPC hitbox → fires ShopProximity
                                  → client shows/hides shop GUI
   door/ToggleDoor              — ClickDetector door; only survivors (or
                                  anyone when Status == 2) can open it

┌─────────────────────────────────────────────────────────────────────────────┐
│                        CLIENT SCRIPTS                                       │
└─────────────────────────────────────────────────────────────────────────────┘

   MainGui/clientgui      — char select buttons → CharSelect:FireServer,
                            listens to timeupdate/roundStart for the
                            countdown + state label
   ShopTestGui            — OpenCloseScript toggles GUI on ShopProximity;
                            TabScript builds shop cards from ShopManager
                            and fires BuyItem; CoinsDisplayScript shows
                            leaderstats coins
   PostGui/PostGuiScript  — shown only to the killer (listens to KillerId);
                            buttons fire PostRequest ("dark", "bright",
                            "desaturate", "oversaturate")
   Client/PostProcessing  — applies effects to Lighting (ClockTime /
                            ColorCorrection), resets on roundEnd

╔════════════════════════════════════════════════════════════════════════════╗
║                        DATA FLOW EXAMPLES                                  ║
╚════════════════════════════════════════════════════════════════════════════╝

ROUND LOOP (main.server):

  main.server        roundManager         CharacterManager      Clients
      │                   │                      │                 │
      ├──startRound()────►│                      │                 │
      │                   ├──GetKillerNumber()──►│                 │
      │                   │◄────KillerId─────────┤                 │
      │                   ├──loadMap() (MapLoader)                 │
      │                   ├──roundStart/KillerId events ──────────►│
      │                   ├──roundStart(player, killer) ───────────►│
      │◄──map─────────────┤                      │                 │
      │  ... 30s later ...                                        │
      ├──stopRound(map)──►│  (back to lobby, destroy map,          │
      │                   │   KillerId = nil)                      │

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

KILLER POST-PROCESSING:

  PostGui (killer)   PostRequest Event   main.server + PostManager   PostProcessing Event
      │                    │                     │                        │
      ├────"dark"─────────►│                     │                        │
      │                    ├──OnServerEvent─────►│                        │
      │                    │                     ├──check Status+KillerId─┤
      │                    │                     ├──fire effect to all───►│
      │                    │                     │                  clients' Lighting

COIN PAD INTERACTION:

  Player touches     ▼  CoinPads Script detects   ▼  leaderstats.Coins
  CoinPad        proximity prompt              updates locally
