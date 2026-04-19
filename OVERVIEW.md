# Punishing: Gray Raven Helper

A monorepo containing a scraper, REST API backend, and frontend apps for surfacing Punishing: Gray Raven game data sourced from the [grayravens.com](https://grayravens.com) community wiki.

## Monorepo Structure

```
punishing_gray_raven_helper/
├── scraper/            # Node/TS scrapers
├── apps/
│   ├── backend/        # Express REST API
│   └── frontend/
│       ├── web/        # React (planned)
│       └── mobile/     # Flutter (planned)
└── shared/             # Shared DB connection and models
```

## Scraper (`scraper/`)

### Memories scraper (`scraper/src/memories.ts`)

Scrapes all **Omniframe Memories** (set equipment) from the wiki:

1. **List page** — Fetches `grayravens.com/wiki/Memories/Omniframe_Memories` and iterates over tabbed panels for each star rating (2–6 stars). Collects each memory's name, individual wiki URL, bust image URL, and star count.

2. **Detail page** — For each memory, visits its wiki page and extracts:
   - Stats: HP, Crit, ATK, DEF (from the first `wikitable`)
   - Set bonuses: 2-piece and 4-piece descriptions
   - Icon images (filenames containing `Icon`)
   - Portrait images (filenames containing `Portrait`)

3. **Image upload** — All images (bust, icons, portraits) are uploaded to ImageKit under `/pgr/memories/{busts|icons|portraits}/`.

4. **Persistence** — Each memory is upserted into MongoDB using Mongoose.

### Characters scraper (`scraper/src/characters.ts`)

Scrapes all playable characters from the wiki:

1. **List page** — Fetches `grayravens.com/wiki/GRAY_RAVENS`, collects all playable character names, wiki URLs, and thumbnail images (stops before the Upcoming Characters section).

2. **Detail page** — For each character, extracts stats, bio, element, rank, class, weapon type, faction, optimal weapon/CUB, memory build, memory resonance, weapon resonances, and character leap info.

3. **Image upload** — Thumbnails and portraits uploaded to ImageKit under `/pgr/characters/{thumbnails|portraits}/`.

4. **Persistence** — Each character is upserted into MongoDB.

## Backend (`apps/backend/`)

Express REST API that serves scraped data to frontend clients.

- **Framework**: Express + TypeScript
- **Database**: MongoDB via Mongoose (shared connection from `shared/`)
- **Routes**: `/api/characters`

## Shared (`shared/`)

- `db_connection.ts` — shared MongoDB connection used by both scraper and backend
- `models/` — shared Mongoose model interfaces

## Stack

| Layer | Technology |
|---|---|
| Language | TypeScript (Node.js, CommonJS) |
| HTTP / Scraping | axios + cheerio |
| Image CDN | ImageKit |
| Database | MongoDB via Mongoose |
| Backend | Express |
| Frontend (planned) | React (web), Flutter (mobile) |
| Config | dotenv |

## Environment Variables

```
MONGO_URI
IMAGE_KIT_PUBLIC_KEY
IMAGE_KIT_PRIVATE_KEY
IMAGE_KIT_URL_ENDPOINT
PORT
```

## Status

- Memories scraper: complete
- Characters scraper: complete
- Shared DB connection: complete
- Backend API: in progress
- Web frontend: planned
- Mobile app: planned