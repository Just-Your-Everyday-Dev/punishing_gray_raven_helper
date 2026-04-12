# PGR Helper — Project Tracker

## What This App Does

A companion app for **Punishing: Gray Raven (PGR)**, a 3D action RPG by Kuro Game.
The app gives players a reference tool to look up game data without visiting the wiki.

**Target platforms:** Flutter Web + Mobile (iOS & Android)

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
| Frontend | Flutter (Web + Mobile) | Firebase Hosting (TBD) | Scaffolded |
| Backend | Node.js + Express + TypeScript | Render (free tier) | Not started |
| Database | MongoDB Atlas (M0 free) | Atlas cloud | Connected, data seeded |
| Image storage | ImageKit | imagekit.io (free) | Working |
| Scraper | TypeScript (ts-node) | Runs locally | Memories done |

---

## Monorepo Structure

```
punishing_gray_raven_helper/
├── apps/
│   ├── backend/          # Express API (TypeScript)
│   │   ├── src/
│   │   │   └── index.ts  # (not yet created)
│   │   ├── package.json
│   │   ├── tsconfig.json
│   │   └── .env          # MONGO_URI
│   └── frontend/         # Flutter app
│       └── lib/
├── scraper/              # One-off data scraping scripts (TypeScript)
│   ├── src/
│   │   ├── memories.ts   # DONE
│   │   └── models/
│   │       └── mongoose_model.ts
│   ├── package.json
│   ├── tsconfig.json
│   └── .env              # MONGO_URI + ImageKit keys
├── package.json          # Root — npm workspaces
└── PROJECT.md
```

---

## Infrastructure Setup

- [x] Flutter project scaffolded
- [x] MongoDB Atlas cluster created (M0 free tier, IP whitelist `0.0.0.0/0`)
- [x] ImageKit account created
- [x] `.env` files configured in `scraper/` and `apps/backend/`
- [x] npm workspaces configured (backend + scraper only, Flutter excluded)
- [x] TypeScript + ts-node configured in both backend and scraper
- [ ] Render account + backend deployed
- [ ] Firebase project linked for Flutter web deploy

---

## Scraper Progress

Source: `grayravens.com` (GRAY RAVENS wiki)

### Memories (`scraper/src/memories.ts`) — COMPLETE
- [x] Scrape list page → 63 memories found across star ratings (6★ to 2★)
- [x] Visit each memory page → extract stats (HP, Crit, ATK, DEF) and set bonuses (2-piece, 4-piece)
- [x] Scrape icon images (`*Icon*`) and portrait images (`*Portrait*`) per memory
- [x] Upload all images to ImageKit under `/pgr/memories/busts`, `/pgr/memories/icons`, `/pgr/memories/portraits`
- [x] Save data + ImageKit URLs to MongoDB Atlas (`memories` collection)
- [x] Upsert logic — safe to re-run without duplicating data

### Memories — Mongoose Model
```typescript
IMemory {
    name: string           // e.g. "Condelina"
    stars: number          // 2–6
    stats: {
        hp: number
        crit: number
        atk: number
        def: number
    }
    setPiece2: string      // 2-piece set bonus description
    setPiece4: string      // 4-piece set bonus description
    bustImageUrl: string   // ImageKit URL
    iconImageUrls: string[] // ImageKit URLs (up to 3)
    portraitImageUrls: string[] // ImageKit URLs (up to 3)
    wikiUrl: string
}
```

### Future Scrapers
- [ ] Characters scraper
- [ ] Weapons scraper
- [ ] Builds (likely manual entry — not in structured form on the wiki)

---

## Backend — API Routes

### Memories
- [ ] `GET /api/memories` — list all memories (with optional `?stars=6` filter)
- [ ] `GET /api/memories/:id` — single memory with full image URLs

### Characters
- [ ] `GET /api/characters` — list all characters
- [ ] `GET /api/characters/:id` — single character

### Weapons
- [ ] `GET /api/weapons` — list all weapons
- [ ] `GET /api/weapons/:id` — single weapon

### Builds
- [ ] `GET /api/builds` — list all builds
- [ ] `GET /api/builds?characterId=xxx` — builds for a specific character

---

## Flutter App — Screens

- [ ] Home screen
- [ ] Memories list screen
- [ ] Memory detail screen
- [ ] Characters list screen
- [ ] Character detail screen
- [ ] Weapons list screen
- [ ] Builds screen (per character)
- [ ] Search screen

### Already in pubspec.yaml
- `dio` + `retrofit` — HTTP client (API calls)
- `flutter_bloc` — state management
- `cached_network_image` — image loading + caching
- `json_serializable` — model generation
- `google_fonts` — typography
- `shared_preferences` — local storage

---

## Data Flow

```
Wiki (grayravens.com)
  └─► scraper downloads images + data
        └─► images uploaded to ImageKit (CDN)
              └─► data + ImageKit URLs saved to MongoDB Atlas
                    └─► Express API serves JSON
                          └─► Flutter app displays content
```

---

## What's Been Done

1. [x] Monorepo structure created with npm workspaces
2. [x] TypeScript configured in both backend and scraper
3. [x] MongoDB Atlas M0 cluster set up and connected
4. [x] ImageKit account set up and integrated
5. [x] Memories scraper built and run — 63 memories saved to MongoDB with images on ImageKit

## Next Steps (in order)

1. **Backend: Express server** — create `apps/backend/src/index.ts` with MongoDB connection
2. **Backend: Memory model** — create `apps/backend/src/models/Memory.ts` (shared schema with scraper)
3. **Backend: Memories routes** — `GET /api/memories` and `GET /api/memories/:id`
4. **Test API** — run backend locally, hit routes with a tool like Postman or curl
5. **Flutter: HTTP client setup** — configure dio/retrofit to call local backend
6. **Flutter: Memories list screen** — display memories from API
7. **Flutter: Memory detail screen** — show stats, set bonuses, images
8. **Deploy backend** — Render free tier
9. **Deploy Flutter web** — Firebase Hosting
10. **Repeat scraper + API for Characters and Weapons**