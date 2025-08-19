# AR Treasure Hunt Game 🎮

A location-based augmented reality treasure hunt game built with **Svelte 5**, **TypeScript**, and **AR.js**. Players use their phone camera to find and collect virtual treasures hidden in the real world.

## 🚀 Features

- **Location-based AR** - Treasures appear based on GPS coordinates
- **Real-time camera feed** - Uses device camera for AR experience  
- **TypeScript** - Full type safety with TypeScript
- **Svelte 5 State Runes** - Modern state management with `$state` and `$derived`
- **Responsive UI** - Mobile-first design optimized for phones
- **Game mechanics** - Score tracking, inventory, level progression

## 🛠️ Tech Stack

- **Framework**: Svelte 5 + SvelteKit
- **Language**: TypeScript
- **AR Library**: AR.js (location-based AR)
- **Package Manager**: pnpm
- **Deployment**: Vercel

## 📱 Prerequisites

The app requires:
- A device with GPS capabilities
- Camera access permissions
- Location access permissions
- Modern mobile browser (Chrome/Safari recommended)

## 🏗️ Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd ar-treasure-hunt

# Install dependencies with pnpm
pnpm install

# Start development server
pnpm dev
```

## 🎮 How to Play

1. **Grant Permissions** - Allow camera and location access when prompted
2. **Start Game** - Click "Start Adventure" to begin
3. **Find Treasures** - Move around to discover nearby treasures (within 100m)
4. **Collect** - Get close to treasures (within 10m) to collect them
5. **Win** - Collect 10 treasures to complete the game!

## 🚀 Deployment to Vercel

The app is configured for easy deployment to Vercel:

### Option 1: Deploy via Git

1. Push your code to GitHub/GitLab/Bitbucket
2. Import the repository in [Vercel Dashboard](https://vercel.com/new)
3. Vercel will auto-detect SvelteKit and configure build settings
4. Deploy!

### Option 2: Deploy via CLI

```bash
# Install Vercel CLI
pnpm i -g vercel

# Deploy (follow prompts)
vercel

# Deploy to production
vercel --prod
```

## 📁 Project Structure

```
ar-treasure-hunt/
├── src/
│   ├── lib/
│   │   ├── components/
│   │   │   ├── ARScene.svelte      # AR camera and tracking
│   │   │   ├── GameUI.svelte       # Game interface overlay
│   │   │   └── TreasureManager.svelte # Treasure detection logic
│   │   └── stores/
│   │       └── gameState.svelte.ts # Svelte 5 state management
│   └── routes/
│       └── +page.svelte            # Main game page
├── static/                         # Static assets
├── vercel.json                     # Vercel configuration
└── package.json
```

## 🔧 Configuration

### Environment Variables

No environment variables required for basic functionality.

### Vercel Settings

The `vercel.json` file is pre-configured with:
- Build command: `pnpm build`
- Output directory: `build`
- Framework: `svelte-kit`

## 🐛 Known Issues

- Minor accessibility warnings in modals (non-blocking)
- Video element missing captions track (AR camera feed)
- Some unused CSS selectors to be cleaned up

## 📝 Development Notes

### State Management
The app uses Svelte 5's new state runes instead of stores:
- `$state()` for reactive state
- `$derived()` for computed values
- Direct property access instead of `$` prefix

### TypeScript Migration
All components are fully typed with:
- Interface definitions for `Treasure` and `PlayerLocation`
- Type-safe event handlers
- Proper TypeScript class for game state

## 📄 License

MIT

## 🤝 Contributing

Contributions welcome! Please ensure:
- Code follows TypeScript best practices
- Components use Svelte 5 state runes
- Mobile-first responsive design
- Accessibility considerations

---

Built with ❤️ using Svelte 5 and TypeScript
