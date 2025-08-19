interface Treasure {
	id: string;
	type: 'gem' | 'coin' | 'chest';
	lat: number;
	lng: number;
	distance: number;
	value: number;
}

interface PlayerLocation {
	lat: number;
	lng: number;
}

class GameState {
	isPlaying = $state(false);
	score = $state(0);
	treasuresFound = $state<string[]>([]);
	totalTreasures = $state(10);
	playerLocation = $state<PlayerLocation | null>(null);
	nearbyTreasures = $state<Treasure[]>([]);
	currentLevel = $state(1);
	coins = $state(0);
	
	// Derived state
	progress = $derived(this.treasuresFound.length > 0 ? 
		(this.treasuresFound.length / 10) * 100 : 0);
	isComplete = $derived(this.treasuresFound.length >= 10);
	
	startGame() {
		this.isPlaying = true;
		this.score = 0;
		this.treasuresFound = [];
		this.coins = 0;
		this.currentLevel = 1;
	}
	
	resetGame() {
		this.isPlaying = false;
		this.score = 0;
		this.treasuresFound = [];
		this.nearbyTreasures = [];
		this.playerLocation = null;
		this.currentLevel = 1;
		this.coins = 0;
	}
	
	pauseGame() {
		this.isPlaying = false;
	}
	
	resumeGame() {
		this.isPlaying = true;
	}
	
	endGame() {
		this.isPlaying = false;
	}
	
	collectTreasure(treasureId: string) {
		if (!this.treasuresFound.includes(treasureId)) {
			const treasure = this.nearbyTreasures.find(t => t.id === treasureId);
			if (treasure) {
				this.treasuresFound = [...this.treasuresFound, treasureId];
				this.score += treasure.value;
				this.coins += Math.floor(Math.random() * 10) + 5;
			}
		}
	}
	
	updateLocation(location: PlayerLocation) {
		this.playerLocation = location;
	}
	
	updateNearbyTreasures(treasures: Treasure[]) {
		this.nearbyTreasures = treasures;
	}
	
	levelUp() {
		this.currentLevel++;
		this.totalTreasures += 5;
	}
}

export const gameState = new GameState();
export type { Treasure, PlayerLocation };
