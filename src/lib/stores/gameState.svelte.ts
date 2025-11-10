import { goto } from '$app/navigation';
import { getContext, setContext } from 'svelte';

export interface GameStateProps {
	playerName: string;
	startTime: number;
	currentTreasureIndex: number;
}

export interface Treasure {
	id: number;
	emoji: string;
	name: string;
	clue: string;
	markerId: string;
	markerType: 'kanji' | 'hiro';
	found: boolean;
	capturedAt?: Date;
}

// Pistas e tesouros para o jogo (Phase 1 - 10 tesouros)
const initialTreasures: Treasure[] = [
	{
		id: 1,
		emoji: '📚',
		name: 'Ministério de Jesus',
		clue: 'Durante seu ministério, Jesus curou um homem que esperava por um milagre há 38 anos. Onde ele foi?',
		markerId: 'marker-1',
		markerType: 'kanji',
		found: false
	}
];
// 	{
// 		id: 2,
// 		emoji: '🎨',
// 		name: 'Paleta das Cores',
// 		clue: 'No lugar onde a criatividade ganha vida, encontre o arco-íris escondido.',
// 		markerId: 'marker-2',
// 		markerType: 'kanji',
// 		found: false
// 	},
// 	{
// 		id: 3,
// 		emoji: '⚽',
// 		name: 'Bola Dourada',
// 		clue: 'Onde os campeões praticam seus sonhos, procure pela glória esportiva.',
// 		markerId: 'marker-3',
// 		markerType: 'kanji',
// 		found: false
// 	},
// 	{
// 		id: 4,
// 		emoji: '🎭',
// 		name: 'Máscara Misteriosa',
// 		clue: 'No palco onde histórias ganham vida, a cortina esconde um segredo.',
// 		markerId: 'marker-4',
// 		markerType: 'hiro',
// 		found: false
// 	},
// 	{
// 		id: 5,
// 		emoji: '🔬',
// 		name: 'Frasco da Ciência',
// 		clue: 'No laboratório das descobertas, o conhecimento borbulha em segredo.',
// 		markerId: 'marker-5',
// 		markerType: 'kanji',
// 		found: false
// 	},
// 	{
// 		id: 6,
// 		emoji: '🎵',
// 		name: 'Nota Musical',
// 		clue: 'Onde as melodias ecoam, encontre a harmonia perdida.',
// 		markerId: 'marker-6',
// 		markerType: 'hiro',
// 		found: false
// 	},
// 	{
// 		id: 7,
// 		emoji: '🌟',
// 		name: 'Estrela Brilhante',
// 		clue: 'No topo do mundo escolar, uma luz guia os perdidos.',
// 		markerId: 'marker-7',
// 		markerType: 'kanji',
// 		found: false
// 	},
// 	{
// 		id: 8,
// 		emoji: '🏆',
// 		name: 'Troféu da Vitória',
// 		clue: 'Na sala dos campeões, a glória espera por você.',
// 		markerId: 'marker-8',
// 		markerType: 'hiro',
// 		found: false
// 	},
// 	{
// 		id: 9,
// 		emoji: '💎',
// 		name: 'Diamante Raro',
// 		clue: 'No cofre do diretor, um tesouro especial aguarda.',
// 		markerId: 'marker-9',
// 		markerType: 'kanji',
// 		found: false
// 	},
// 	{
// 		id: 10,
// 		emoji: '👑',
// 		name: 'Coroa Real',
// 		clue: 'No trono do conhecimento, a realeza do saber reina suprema.',
// 		markerId: 'marker-10',
// 		markerType: 'hiro',
// 		found: false
// 	}
// ];

export class GameState {
	playerName: string;
	gameStartTime = $state<Date | null>(null);
	startTime: number;
	elapsedTime = $state(0);
	currentTreasureIndex: number;
	treasures = $state<Treasure[]>([...initialTreasures]);
	totalTime = $state('00:00');
	isGameActive = $state(false);

	private timerInterval: ReturnType<typeof setInterval> | null = null;

	constructor(props?: GameStateProps) {
		this.playerName = $state(props?.playerName || '');
		this.startTime = $state(props?.startTime || 0);
		this.currentTreasureIndex = $state(props?.currentTreasureIndex || 0);

		// Start the timer effect
		$effect(() => {
			if (this.isGameActive && this.gameStartTime) {
				this.startTimer();
			} else {
				this.stopTimer();
			}
		});

		// Update total time based on elapsed time
		$effect(() => {
			if (this.startTime > 0) {
				const elapsed = this.elapsedTime;
				const minutes = Math.floor(elapsed / 60000);
				const seconds = Math.floor((elapsed % 60000) / 1000);
				this.totalTime = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
			}
		});
	}

	private startTimer() {
		if (this.timerInterval) return;

		this.timerInterval = setInterval(() => {
			if (this.gameStartTime && this.isGameActive) {
				const now = new Date();
				const diff = now.getTime() - this.gameStartTime.getTime();
				const minutes = Math.floor(diff / 60000);
				const seconds = Math.floor((diff % 60000) / 1000);
				this.totalTime = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
			}

			if (this.startTime > 0) {
				this.elapsedTime = Date.now() - this.startTime;
			}
		}, 1000);
	}

	private stopTimer() {
		if (this.timerInterval) {
			clearInterval(this.timerInterval);
			this.timerInterval = null;
		}
	}

	startGame(playerName: string) {
		this.playerName = playerName;
		this.startTime = Date.now();
		this.elapsedTime = 0;
		this.isGameActive = true;

		goto('/clue');
	}

	resumeGame() {
		goto('/clue');
	}

	captureTreasure() {
		const currentTreasure = this.treasures[this.currentTreasureIndex];
		currentTreasure.found = true;
		currentTreasure.capturedAt = new Date();
		goto('/capture-success');
	}

	nextTreasure() {
		const nextIndex = this.currentTreasureIndex + 1;

		// Check if all treasures are found
		if (nextIndex >= this.treasures.length) {
			this.isGameActive = false;
			goto('/clue');
			return;
		}

		this.currentTreasureIndex = nextIndex;
		goto('/clue');
	}

	resetGame() {
		this.stopTimer();
		goto('/name-entry');
		this.playerName = '';
		this.gameStartTime = null;
		this.startTime = 0;
		this.elapsedTime = 0;
		this.currentTreasureIndex = 0;
		this.treasures = [...initialTreasures];
		this.totalTime = '00:00';
		this.isGameActive = false;
	}
}

export function createGameState(props?: GameStateProps) {
	const gameState = new GameState(props);
	setContext<GameState>('gameState', gameState);
	return gameState;
}

export function getGameState() {
	return getContext<GameState>('gameState');
}
