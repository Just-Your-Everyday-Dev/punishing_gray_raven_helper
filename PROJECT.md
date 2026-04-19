# PGR Helper — Project Tracker

## What This App Does

A companion app for **Punishing: Gray Raven (PGR)**, a 3D action RPG by Kuro Games.
The app gives players a reference tool to look up game data without visiting the wiki.

**Target platforms:** Web (React) + Mobile (Flutter)

---

## Scope

### Features
- [ ] Browse **Memories** (equipment sets) with stats and images
- [ ] Browse **Characters** (Constructs) with their details
- [ ] Browse **Weapons** with stats
- [ ] View recommended **Builds** per character (memory + weapon combos)
- [ ] Filter/search across all categories

### Out of Scope (for now)
- User accounts / login
- Community features (comments, ratings)
- Real-time game data (events, banners)
- CN/JP server data (Global only)

---

## Tech Stack

| Layer | Technology | Hosting | Status |
|---|---|---|---|
| Web Frontend | React | TBD | Planned |
| Mobile Frontend | Flutter | TBD | Planned |
| Backend | Node.js + Express + TypeScript | Render (free tier) | In Progress |
| Database | MongoDB Atlas (M0 free) | Atlas cloud | Connected, data seeded |
| Image storage | ImageKit | imagekit.io (free) | Working |
| Scraper | TypeScript (ts-node) | Runs locally | Memories + Characters done |

---

## Monorepo Structure

```
punishing_gray_raven_helper/
├── apps/
│   ├── backend/                    # Express API (TypeScript)
│   │   ├── src/
│   │   │   ├── index.ts            # Entry point — Express app, DB connect, listen
│   │   │   ├── routes/
│   │   │   │   └── characters_route.ts    # (stub — in progress)
│   │   │   └── controllers/
│   │   │       └── characters_controller.ts  # (stub — in progress)
│   │   ├── package.json
│   │   └── tsconfig.json
│   └── frontend/
│       ├── web/                    # React app (planned)
│       └── mobile/                 # Flutter app (planned)
├── scraper/                        # One-off data scraping scripts
│   ├── src/
│   │   ├── memories.ts             # DONE
│   │   ├── characters.ts           # DONE
│   │   └── models/
│   │       └── character_model.ts  # local interface (being migrated to shared)
│   ├── package.json
│   └── tsconfig.json
├── shared/                         # Shared across scraper and backend
│   ├── db_connection.ts            # MongoDB connect function
│   └── models/
│       └── character_model.ts      # ICharacter interface
├── package.json                    # Root — npm workspaces
└── PROJECT.md
```

---

## Infrastructure Setup

- [x] MongoDB Atlas cluster created (M0 free tier, IP whitelist `0.0.0.0/0`)
- [x] ImageKit account created and integrated
- [x] `.env` files configured in `scraper/` and `apps/backend/`
- [x] npm workspaces configured (root `package.json`)
- [x] TypeScript + ts-node configured in backend and scraper
- [ ] Render account + backend deployed
- [ ] Frontend hosting set up

---

## Scraper Progress

Source: `grayravens.com` (GRAY RAVENS wiki)

### Memories (`scraper/src/memories.ts`) — COMPLETE
- [x] Scrape list page → 63 memories across star ratings (6★ to 2★)
- [x] Extract stats (HP, Crit, ATK, DEF) and set bonuses (2-piece, 4-piece)
- [x] Upload images to ImageKit under `/pgr/memories/`
- [x] Upsert into MongoDB (`memories` collection)

### Characters (`scraper/src/characters.ts`) — COMPLETE
- [x] Scrape list page → all playable characters (stops before Upcoming section)
- [x] Extract stats, bio, element, rank, class, weapon type, faction, optimal weapon/CUB, memory build, memory resonance, weapon resonances, character leap
- [x] Upload thumbnails and portraits to ImageKit under `/pgr/characters/`
- [x] Upsert into MongoDB (`characters` collection)

### Shared
- [x] `shared/db_connection.ts` — shared MongoDB connect, used by both scraper and backend
- [x] `shared/models/character_model.ts` — shared `ICharacter` interface

### Future Scrapers
- [ ] Weapons scraper
- [ ] Builds (likely manual entry)

---

## Backend — API Routes

### Characters
- [ ] `GET /api/characters` — list all characters (name, thumbnail, element, rank)
- [ ] `GET /api/characters/:name` — full character detail

### Memories
- [ ] `GET /api/memories` — list all memories
- [ ] `GET /api/memories/:name` — single memory detail

### Weapons
- [ ] `GET /api/weapons` — list all weapons
- [ ] `GET /api/weapons/:name` — single weapon detail

---

## What's Been Done

1. [x] Monorepo structure created with npm workspaces
2. [x] TypeScript configured in backend and scraper
3. [x] MongoDB Atlas M0 cluster set up and connected
4. [x] ImageKit integrated
5. [x] Memories scraper — 63 memories saved to MongoDB with images on ImageKit
6. [x] Characters scraper — all playable characters saved to MongoDB with images on ImageKit
7. [x] Shared DB connection extracted to `shared/db_connection.ts`
8. [x] Shared character model interface in `shared/models/character_model.ts`
9. [x] Express backend scaffolded — `index.ts` running, MongoDB connected, server on port 3000
10. [x] Character route and controller files created (stubs — to be filled next session)

## Next Steps (in order)

1. **Backend: Characters controller** — implement `getAllCharacters` and `getCharacterByName`
2. **Backend: Characters route** — wire controller to `GET /api/characters` and `GET /api/characters/:name`
3. **Test API** — hit routes with Postman or curl
4. **Backend: Memories routes** — repeat for memories
5. **Deploy backend** — Render free tier
6. **Web frontend** — scaffold React app in `apps/frontend/web/`
7. **Mobile frontend** — scaffold Flutter app in `apps/frontend/mobile/`
