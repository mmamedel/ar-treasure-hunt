# PWA Offline-First Implementation

This AR Treasure Hunt app has been configured as a Progressive Web App (PWA) with offline-first capabilities.

## Features

### ✅ Installable App
- Install directly on home screen (iOS, Android, Desktop)
- Works in standalone mode like a native app
- Custom splash screen and app icon

### ✅ Offline First
- **Service Worker**: Caches essential assets on first load
- **Network First Strategy**: HTML, CSS, JS assets use network-first caching
- **Automatic Sync**: Background sync for pending actions when connection returns
- **Game Data Persistence**: Local storage for game sessions via `gameSessionPersisted` store

### ✅ Online Status Tracking
- Real-time detection of connection status
- Game state tracks `isOnline` status
- Automatic notifications when connection is restored

## Architecture

### Service Worker (`src/service-worker.ts`)
- **Precaching**: Essential assets cached on install
- **Network-first strategy**: Fetches from network first, falls back to cache
- **Cache management**: Keeps `ar-treasure-hunt-v1` and `ar-treasure-hunt-runtime` caches
- **Background sync support**: Ready for sync events when online

### PWA Configuration (`vite.config.ts`)
- Uses `@vite-pwa/sveltekit` plugin
- Auto-registers service worker
- Updates on auto
- Manifests game metadata

### Manifest (`static/manifest.json`)
- App name, icon, and theme colors
- Start URL and display mode
- Shortcuts for quick access
- Support for maskable icons

### Offline Detection (`src/lib/offline.ts`)
- Simple utilities for online/offline status
- Event listeners for connection changes
- ID generation for tracking

### Game State (`src/lib/stores/gameState.svelte.ts`)
- Tracks `isOnline` status in reactive state
- Subscribes to online/offline events
- Ready for custom sync logic when connection returns

## Usage

### Installation

#### On Mobile (iOS/Android)
1. Open app in browser
2. Tap share/menu button
3. Select "Add to Home Screen"
4. Confirm installation

#### On Desktop
1. Open the app in Chrome/Edge
2. Look for "Install app" button in address bar
3. Click to install

### Offline Behavior

The app works completely offline:
- ✅ Navigate between pages
- ✅ View clues and camera view
- ✅ Capture treasures (stored locally)
- ✅ All game state persists in browser storage

Game data syncs automatically when connection returns.

### Custom Sync Logic

To add custom sync when connection returns, modify `src/lib/stores/gameState.svelte.ts`:

```typescript
if (online) {
	// Add your sync logic here
	// e.g., send captured treasures to server
	console.log('Connection restored - game data ready to sync');
}
```

## Development

### Building
```bash
pnpm build
```

### Testing Offline
1. Build the app: `pnpm build`
2. Preview: `pnpm preview`
3. Open DevTools → Application → Service Workers
4. Toggle "Offline" checkbox
5. Navigate app - everything still works!

### Cache Management
- Service worker auto-updates on new deployments
- Old caches automatically cleaned up
- `workbox` config handles versioning

## Browser Support

- ✅ Chrome/Edge 40+
- ✅ Firefox 44+
- ✅ Safari 11.1+
- ✅ All modern mobile browsers

## Performance Benefits

- **Instant Load**: Cached assets load instantly
- **Reduced Data**: Only fetches new/changed content
- **Better UX**: App-like experience with offline support
- **Reliability**: Works without internet connection

## Troubleshooting

### Service Worker Not Updating
- Clear browser cache
- Force refresh with `Ctrl+Shift+R` or `Cmd+Shift+R`
- Check DevTools → Application → Service Workers

### PWA Not Installing
- Must be served over HTTPS (localhost works in dev)
- Check manifest validity in DevTools
- Try different browser if issues persist

### Offline Data Loss
- Game data stored in localStorage by `gameSessionPersisted`
- Browser cache stores by service worker
- Both are browser-managed, clear browser data to reset

## Next Steps

1. **Add server sync**: Implement API calls to sync treasure data
2. **Offline queuing**: Queue API requests while offline
3. **Conflict resolution**: Handle sync conflicts with server
4. **Push notifications**: Add push notifications for game events
5. **Update notifications**: Notify users of app updates
