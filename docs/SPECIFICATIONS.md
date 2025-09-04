# Treasure Hunt POC - Project Specifications

## 1. Project Overview

### 1.1 Purpose
The Treasure Hunt POC is a clue-based AR treasure hunt web application where players follow clues to find physical AR markers. Each clue leads to the location of the next physical marker. Players use their device cameras to scan markers and capture 3D AR objects, progressing through a sequential series of challenges until completion.

### 1.2 Project Goals
- Create an engaging clue-based treasure hunt experience
- Use physical AR markers instead of GPS locations for treasure discovery
- Provide AR visualization of 3D objects at marker locations
- Track player progression and completion time
- Generate completion QR codes for staff verification
- Maintain a real-time leaderboard system
- Deploy as a web application via Vercel for instant updates

## 2. Core Features

### 2.1 Player Access & Progress
- **Game Access**
  - Players access the game via web link or QR code
  - Enter a display name on first load (required)
  - Tutorial explaining gameplay mechanics
  - No registration or login required
  - Unique player ID generated per device
  
- **Game Time Window**
  - Game active only during scheduled time period
  - Before start time: "Game starts at [time]" message
  - During active period: Full gameplay enabled
  - After end time: Leaderboard-only view
  
- **Local Device Storage**
  - All progress saved locally on device (localStorage/IndexedDB)
  - Player name and current clue persisted
  - Captured items and completion time tracked
  - Progress tied to specific device/browser

### 2.2 Clue-Based AR Hunt Gameplay
- **Clue System**
  - Sequential clues presented one at a time
  - Each clue leads to next physical marker location
  - Progress to next clue only after capturing current item
  - Tutorial at start explaining game mechanics
  
- **AR Experience**
  - Camera-based AR view for scanning physical markers
  - 3D objects rendered when marker is detected
  - Objects are customized to relate to the answer
  - Tap-to-capture interface when object is visible
  - No GPS tracking required

- **Core Mechanics**
  - Sequential progression through clues
  - Time tracking from start to completion
  - Bonus items for speed achievements (TBD)
  - Completion QR code generation for verification
  - Real-time leaderboard showing top 10 and player position

### 2.3 Game Administration
- **Game Scheduling**
  - Set game start date/time
  - Set game end date/time
  - Configure timezone
  - Enable/disable game manually
  
- **Clue & Marker Management**
  - Configure clues for each location
  - Set up AR marker associations
  - Configure 3D objects for each marker
  - Define bonus item criteria
  - Set clue sequence
  
- **User Moderation**
  - View player list with names and progress
  - Rename players with inappropriate names
  - Export final leaderboard results
  
- **Staff Verification Tools**
  - QR code scanner for completion verification
  - View player completion time and bonus items
  - Mark players as verified
  - Real-time completion statistics

### 2.4 Competition Features
- **Leaderboard System**
  - Primary ranking: Total treasures collected
  - Tiebreaker: Collection speed (treasures per minute)
  - Shows top 10 players
  - Shows player's current position
  - Real-time updates
  
- **Completion Verification**
  - QR code generated upon game completion
  - Contains player ID, completion time, bonus items
  - Staff scans QR at game booth for verification
  - Prevents cheating through staff validation

## 3. User Stories

### 3.1 As a Player
- I want to access the game and enter my name
- I want to see a tutorial explaining how to play
- I want to receive clues to find marker locations
- I want to scan physical markers with my camera
- I want to see 3D AR objects when I find the right marker
- I want to capture AR objects by tapping them
- I want to progress to the next clue after capturing an item
- I want to see the leaderboard at any time
- I want to see my position on the leaderboard
- I want to receive a completion QR code when I finish all clues
- I want to show my QR code to staff at the game booth

### 3.2 As Game Staff
- I want to scan player completion QR codes
- I want to verify player completion status
- I want to see player completion time
- I want to see bonus items collected
- I want to mark players as verified

### 3.3 As an Admin
- I want to schedule game start and end times
- I want to create and manage clues
- I want to configure AR markers and 3D objects
- I want to monitor player progress in real-time
- I want to view and export leaderboard data
- I want to rename inappropriate player names
- I want to configure bonus item criteria

## 4. Technical Requirements

### 4.1 Frontend
- **Framework**: SvelteKit with Svelte 5
- **Language**: TypeScript (strict mode)
- **State Management**: Svelte 5 $state runes (no stores)
- **Styling**: Regular CSS with CSS Modules
- **AR Library**: AR.js
- **3D Models**: Three.js for treasure rendering

### 4.2 Backend
- **Framework**: SvelteKit API routes
- **Database**: Upstash Redis (free tier: 10K commands/day, 256MB)
- **Progress Updates**: On clue completion only
- **Clue Data**: Static JSON files deployed with app
- **File Storage**: Static assets served from Vercel
- **Authentication**: None - device ID based
- **Leaderboard**: Calculated from Redis, updated on completion
- **QR Generation**: Client-side generation with encryption
- **Rate Limiting**: Per-device throttling

### 4.3 Infrastructure (Free Tier)
- **Deployment**: Vercel free tier (100GB bandwidth/month)
- **Repository**: GitHub (free)
- **CI/CD**: GitHub Actions (free) + Vercel
- **Database**: Upstash Redis free tier (10K commands/day)
- **Data Storage**: All game data in KV store (treasures, players, leaderboard)
- **Monitoring**: Vercel Analytics (free tier)
- **CDN**: Vercel's free CDN for static content
- **Cost**: $0/month for all infrastructure

### 4.4 Mobile & AR Requirements
- **Web Application**
  - Mobile-optimized responsive design
  - Offline clue data caching
  - Progress saved locally
  - No GPS tracking required

- **AR Capabilities**
  - AR.js for marker detection
  - Camera permissions required
  - Physical marker tracking
  - 3D object rendering on markers
  - Fallback message if AR unavailable

- **Performance**
  - 60 FPS AR rendering target
  - Optimized 3D models (< 1MB each)
  - Fast marker detection
  - Battery usage optimization

## 5. Data Models

### 5.1 Core Entities
```
Player (Local Storage)
- id: UUID (device-generated)
- name: string (required, entered on first load)
- current_clue: integer (0-based index)
- start_time: timestamp
- completion_time: timestamp (null if not completed)
- total_time_seconds: float
- bonus_items: array of bonus item IDs
- completed: boolean
- verified: boolean (false until staff verification)
- clues_completed: array of {clue_id, timestamp}

GameConfig (KV Store)
- key: "game:config"
- value: { start_time, end_time, timezone, is_active }

Player Progress (KV Store)
- key: "player:{deviceId}"
- value: { 
  name, 
  current_clue,
  start_time,
  completion_time,
  bonus_items,
  verified,
  last_update
}

Leaderboard (KV Store)
- key: "leaderboard"
- value: sorted set by treasures collected (collection speed as tiebreaker)

Clue (Static JSON)
- id: string
- order: integer (sequence number)
- clue_text: string (displayed to help find marker)
- hint: string (optional, additional help)
- marker_id: string (AR marker to find)
- ar_object: {
  model_url: string,
  scale: number,
  animation: string (optional)
}

ARMarker (Static JSON)
- id: string
- pattern_url: string (marker pattern file)
- associated_clue: string
- 3d_object: {
  model_url: string,
  texture_url: string,
  position: {x, y, z},
  rotation: {x, y, z},
  scale: number
}

CompletionData (Generated QR Code)
- player_id: UUID
- player_name: string
- completion_time: timestamp
- total_time_seconds: float
- bonus_items: array
- verification_hash: string (prevent tampering)
- qr_generated_at: timestamp

BonusItem (Static JSON)
- id: string
- name: string
- criteria: {
  type: enum (speed, accuracy, special),
  threshold: number,
  description: string
}
- icon_url: string
```

## 6. UI/UX Requirements

### 6.1 Design Principles
- Mobile-first responsive design
- Intuitive navigation in Portuguese (Brasil)
- Gamified visual elements
- Simple, clean interface
- High contrast for outdoor visibility
- Clear clue presentation

### 6.2 Screens
- **Name Entry**: Initial screen for first-time users
- **Tutorial**: Explains how to play, find markers, and capture items
- **Pre-Game Screen**: Shows countdown to game start
- **Clue Screen**: Displays location clue to find next marker
- **AR Camera View**: Camera view for scanning markers and capturing objects
- **Capture Success**: Confirmation screen with next clue button
- **Leaderboard**: Top 10 players and current player position
- **Completion Screen**: Shows QR code for staff verification
- **Post-Game Screen**: Leaderboard-only view after game ends
- **Admin Panel**: Clue management, player monitoring, and statistics
- **Staff Scanner**: QR code scanner interface for game booth staff

## 7. Security Considerations

- Input validation and sanitization
- Rate limiting on API endpoints
- Secure storage of sensitive data
- HTTPS enforcement
- CORS configuration
- Content Security Policy
- Protection against common vulnerabilities (XSS, CSRF, SQL injection)

## 8. Performance Requirements

### 8.1 Infrastructure Strategy
- **Upstash Redis Free Tier** (10K commands/day)
- Progress updates only on clue completion
- Leaderboard updates on game completion only
- Expected usage: <5K Redis commands for 500 users
- Stay within free tier limits

### 8.2 Performance Targets  
- Page load time < 3 seconds
- API response time < 200ms
- Support for 500 concurrent users
- AR marker detection < 1 second
- 3D object rendering < 2 seconds
- QR code generation < 500ms
- Clue data cached locally
- Aggressive client-side caching
- Rate limiting: 5 requests/minute per device

## 9. MVP Scope

### Phase 1 (MVP) - Core Clue Hunt
- Name entry screen (Portuguese)
- Sequential clue system
- AR marker scanning
- 3D object capture mechanics
- Progress tracking (local storage)

### Phase 2 - Enhanced Features
- Tutorial explaining gameplay
- Completion QR code generation
- Leaderboard (top 10 + player position)
- Staff QR scanner interface
- Game scheduling (start/end times)
- Basic admin panel
- Bonus item system
- Performance optimizations

### Phase 3 - Advanced Features
- Custom AR effects and animations
- Achievement system
- Player profiles and history

## 10. Success Metrics
- Peak concurrent users (target: 3000)
- Average session length
- Treasures collected per user
- Average collection speed (treasures/minute)
- Completion rate (% of players who finish all clues)
- Leaderboard participation rate
- API response times under load
- System uptime during event (target: 99.9%)

## 11. Risks and Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| AR marker detection issues | High | Test markers in various lighting, provide backup QR codes |
| Players sharing clues | Medium | Time penalties, unique clue order per player group |
| QR code tampering | Medium | Cryptographic signing, server-side verification |
| Camera permissions denied | High | Clear instructions, fallback to manual code entry |
| Slow marker detection | Medium | Optimize marker patterns, reduce 3D model complexity |
| Network issues during completion | High | Local storage of completion data, retry mechanism |
| Physical markers damaged/moved | High | Multiple backup markers, staff on standby |
| Inappropriate usernames | Low | Admin moderation panel, profanity filter |
| Browser AR compatibility | Medium | Support AR.js, clear compatibility warnings |

## 12. Timeline Estimate

- **Week 1-2**: Setup and core infrastructure
- **Week 3-4**: User authentication and basic UI
- **Week 5-6**: Hunt creation and gameplay mechanics
- **Week 7-8**: Scoring and leaderboards
- **Week 9-10**: Testing and refinement
- **Week 11-12**: Deployment and documentation

## 13. Design Decisions

1. **Offline Play**: Partial - clues cached locally, leaderboard requires connection
2. **Clue Progression**: Sequential only - must complete in order
3. **AR Markers**: Physical markers placed at venue locations
4. **Completion Verification**: QR code shown to staff at game booth
5. **Language**: Portuguese (Brasil) only
6. **Bonus Items**: Speed-based achievements (details TBD)
7. **Anti-cheat**: Staff verification required for prizes

## 14. Next Steps

1. Review and approve specifications
2. Choose technology stack
3. Create detailed wireframes/mockups
4. Set up development environment
5. Begin implementation of core features
