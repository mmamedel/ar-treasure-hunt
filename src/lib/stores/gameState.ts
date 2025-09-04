import { writable, type Writable } from 'svelte/store';

export type GameScreen = 'name-entry' | 'clue' | 'ar-camera' | 'capture-success';

export interface Treasure {
	id: number;
	emoji: string;
	name: string;
	clue: string;
	markerId: string;
	found: boolean;
	capturedAt?: Date;
}

export interface GameState {
	currentScreen: GameScreen;
	playerName: string;
	gameStartTime: Date | null;
	startTime: number;
	elapsedTime: number;
	currentTreasureIndex: number;
	treasures: Treasure[];
	totalTime: string;
	isGameActive: boolean;
}

// Pistas e tesouros para o jogo (Phase 1 - 10 tesouros)
const initialTreasures: Treasure[] = [
	{
		id: 1,
		emoji: '📚',
		name: 'Livro do Conhecimento',
		clue: 'Onde as mentes jovens se reúnem para aprender, procure pelo símbolo do saber eterno.',
		markerId: 'marker-1',
		found: false
	},
	{
		id: 2,
		emoji: '🎨',
		name: 'Paleta das Cores',
		clue: 'No lugar onde a criatividade ganha vida, encontre o arco-íris escondido.',
		markerId: 'marker-2',
		found: false
	},
	{
		id: 3,
		emoji: '⚽',
		name: 'Bola Dourada',
		clue: 'Onde os campeões praticam seus sonhos, procure pela glória esportiva.',
		markerId: 'marker-3',
		found: false
	},
	{
		id: 4,
		emoji: '🎭',
		name: 'Máscara Misteriosa',
		clue: 'No palco onde histórias ganham vida, a cortina esconde um segredo.',
		markerId: 'marker-4',
		found: false
	},
	{
		id: 5,
		emoji: '🔬',
		name: 'Frasco da Ciência',
		clue: 'No laboratório das descobertas, o conhecimento borbulha em segredo.',
		markerId: 'marker-5',
		found: false
	},
	{
		id: 6,
		emoji: '🎵',
		name: 'Nota Musical',
		clue: 'Onde as melodias ecoam, encontre a harmonia perdida.',
		markerId: 'marker-6',
		found: false
	},
	{
		id: 7,
		emoji: '🌟',
		name: 'Estrela Brilhante',
		clue: 'No topo do mundo escolar, uma luz guia os perdidos.',
		markerId: 'marker-7',
		found: false
	},
	{
		id: 8,
		emoji: '🏆',
		name: 'Troféu da Vitória',
		clue: 'Na sala dos campeões, a glória espera por você.',
		markerId: 'marker-8',
		found: false
	},
	{
		id: 9,
		emoji: '💎',
		name: 'Diamante Raro',
		clue: 'No cofre do diretor, um tesouro especial aguarda.',
		markerId: 'marker-9',
		found: false
	},
	{
		id: 10,
		emoji: '👑',
		name: 'Coroa Real',
		clue: 'No trono do conhecimento, a realeza do saber reina suprema.',
		markerId: 'marker-10',
		found: false
	}
];

const initialState: GameState = {
	currentScreen: 'name-entry',
	playerName: '',
	gameStartTime: null,
	startTime: 0,
	elapsedTime: 0,
	currentTreasureIndex: 0,
	treasures: initialTreasures,
	totalTime: '00:00',
	isGameActive: false
};

function createGameStore() {
	const { subscribe, set, update } = writable<GameState>(initialState);

	let timerInterval: ReturnType<typeof setInterval> | null = null;

	function startTimer() {
		if (timerInterval) return;
		
		timerInterval = setInterval(() => {
			update(state => {
				if (!state.gameStartTime || !state.isGameActive) return state;
				
				const now = new Date();
				const diff = now.getTime() - state.gameStartTime.getTime();
				const minutes = Math.floor(diff / 60000);
				const seconds = Math.floor((diff % 60000) / 1000);
				
				return {
					...state,
					totalTime: `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
				};
			});
		}, 1000);
	}

	function stopTimer() {
		if (timerInterval) {
			clearInterval(timerInterval);
			timerInterval = null;
		}
	}

	return {
		subscribe,
		setPlayerName: (name: string) => {
			update(state => ({
				...state,
				playerName: name
			}));
		},
		startGame: (playerName: string) => {
			update(state => ({
				...state,
				playerName,
				currentScreen: 'clue',
				startTime: Date.now(),
				elapsedTime: 0
			}));

			// Start timer
			if (timerInterval) clearInterval(timerInterval);
			timerInterval = setInterval(() => {
				update(state => ({
					...state,
					elapsedTime: Date.now() - state.startTime
				}));
			}, 1000);
		},
		navigateToScreen: (screen: GameScreen) => {
			update(state => ({
				...state,
				currentScreen: screen
			}));
		},
		captureTreasure: () => {
			update(state => {
				const newTreasures = [...state.treasures];
				newTreasures[state.currentTreasureIndex] = {
					...newTreasures[state.currentTreasureIndex],
					found: true,
					capturedAt: new Date()
				};

				return {
					...state,
					treasures: newTreasures,
					currentScreen: 'capture-success'
				};
			});
		},
		nextTreasure: () => {
			update(state => {
				const nextIndex = state.currentTreasureIndex + 1;
				
				// Check if all treasures are found
				if (nextIndex >= state.treasures.length) {
					stopTimer();
					return {
						...state,
						isGameActive: false,
						currentScreen: 'clue' // Will show completion in Phase 2
					};
				}

				return {
					...state,
					currentTreasureIndex: nextIndex,
					currentScreen: 'clue'
				};
			});
		},
		resetGame: () => {
			stopTimer();
			set(initialState);
		}
	};
}

export const gameState = createGameStore();
