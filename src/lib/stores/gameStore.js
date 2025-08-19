import { writable, derived } from 'svelte/store';

function createGameState() {
	const { subscribe, set, update } = writable({
		isPlaying: false,
		score: 0,
		treasuresFound: [],
		totalTreasures: 10,
		playerLocation: null,
		nearbyTreasures: [],
		currentLevel: 1,
		coins: 0
	});

	return {
		subscribe,
		startGame: () => update(state => ({ ...state, isPlaying: true, score: 0, treasuresFound: [] })),
		endGame: () => update(state => ({ ...state, isPlaying: false })),
		collectTreasure: (treasureId) => update(state => {
			if (!state.treasuresFound.includes(treasureId)) {
				const points = Math.floor(Math.random() * 50) + 10;
				const coins = Math.floor(Math.random() * 10) + 5;
				return {
					...state,
					treasuresFound: [...state.treasuresFound, treasureId],
					score: state.score + points,
					coins: state.coins + coins
				};
			}
			return state;
		}),
		updateLocation: (location) => update(state => ({ ...state, playerLocation: location })),
		updateNearbyTreasures: (treasures) => update(state => ({ ...state, nearbyTreasures: treasures })),
		levelUp: () => update(state => ({ ...state, currentLevel: state.currentLevel + 1 }))
	};
}

export const gameState = createGameState();

export const progress = derived(gameState, $gameState => {
	if ($gameState.totalTreasures === 0) return 0;
	return ($gameState.treasuresFound.length / $gameState.totalTreasures) * 100;
});

export const isGameComplete = derived(gameState, $gameState => 
	$gameState.treasuresFound.length >= $gameState.totalTreasures
);
