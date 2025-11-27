# Game Config Setup Guide

## Overview

The game config system allows you to control when the treasure hunt game is active. It shows different screens based on the game status:

- **Before Start**: Shows countdown until game begins
- **Active**: Normal game flow (name entry and gameplay)
- **Ended**: Thank you message

## Database

A new `GameConfig` table has been added with:

- `startTime`: When the game starts
- `endTime`: When the game ends

## Testing the Different States

### 1. Set Game to Countdown (Before Start)

```bash
npx tsx prisma/seed-game-config.ts
```

This sets the game to start in 5 minutes. You'll see a countdown timer on the NameEntry page.

### 2. Set Game to Active

```bash
npx tsx prisma/set-game-active.ts
```

This makes the game immediately playable (started 1 second ago, ends in 24 hours).

### 3. Set Game to Ended

```bash
npx tsx prisma/set-game-ended.ts
```

This shows the "thank you" message (game ended 1 second ago).

### 4. Remove Game Config (No Restrictions)

```bash
npx prisma studio
```

Then delete the GameConfig entry. The game will work without restrictions.

## API Endpoint

`GET /api/game-config` returns:

```json
{
  "exists": true,
  "status": "before_start" | "active" | "ended",
  "message": "O jogo ainda não começou",
  "startTime": "2024-01-01T10:00:00.000Z",
  "endTime": "2024-01-01T18:00:00.000Z",
  "timeUntilStart": 300000 // milliseconds (only for before_start)
}
```

## Setting Custom Times

You can manually set times using Prisma Studio:

```bash
npx prisma studio
```

Or create your own script:

```typescript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
	const startTime = new Date('2025-01-15T10:00:00'); // Your date
	const endTime = new Date('2025-01-15T18:00:00'); // Your date

	await prisma.gameConfig.upsert({
		where: { id: 1 },
		update: { startTime, endTime },
		create: { id: 1, startTime, endTime }
	});
}

main();
```

## Admin Panel

Access the admin panel at: `/admin`

**Password:** `tesouro2025`

### Admin Features:

- 🔐 Password protected access
- ⏰ Set game start and end times via UI
- 📊 View current game status
- 🗑️ Remove game config (makes game always active)
- 🚪 Logout functionality

The admin panel provides a user-friendly interface to manage game times without needing to run scripts or access the database directly.

## Features

- ✅ Live countdown timer (updates every second)
- ✅ Automatic transition when countdown reaches zero
- ✅ Portuguese messages throughout
- ✅ Responsive design with game theme
- ✅ Falls back to normal gameplay if no config exists
- ✅ Password-protected admin panel
- ✅ Real-time game status display
