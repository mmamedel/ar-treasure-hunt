import { goto } from '$app/navigation';
import { getContext, setContext } from 'svelte';
import { createSession } from './gameSessionPersisted';
import { onOnlineStatusChange } from '../offline';

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
	capturedAt?: number;
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
	startTime: number;
	elapsedTime = $state(0);
	currentTreasureIndex: number;
	treasures = $state<Treasure[]>([...initialTreasures]);
	totalTime = $state('00:00');
	isGameActive: boolean;
	isOnline = $state(true);
	unsubscribeOnlineStatus: (() => void) | null = null;

	private timerInterval: ReturnType<typeof setInterval> | null = null;

	constructor(props?: GameStateProps) {
		this.playerName = $state(props?.playerName || '');
		this.startTime = $state(props?.startTime || 0);
		this.currentTreasureIndex = $state(props?.currentTreasureIndex || 0);
		this.isGameActive = $state(!!props || false);

		// Start/stop the timer based on game active state
		$effect(() => {
			if (this.isGameActive && this.startTime > 0) {
				this.startTimer();
			} else {
				this.stopTimer();
			}
		});

		// Setup online status listener
		if (typeof window !== 'undefined') {
			this.unsubscribeOnlineStatus = onOnlineStatusChange((online) => {
				this.isOnline = online;
				if (online) {
					console.log('Connection restored - game data ready to sync');
				}
			});
		}
	}

	/** Starts the interval timer that updates every second for live UI display */
	private startTimer() {
		if (this.timerInterval) return;

		this.timerInterval = setInterval(() => {
			if (this.startTime > 0 && this.isGameActive) {
				this.elapsedTime = Date.now() - this.startTime;
				const minutes = Math.floor(this.elapsedTime / 60000);
				const seconds = Math.floor((this.elapsedTime % 60000) / 1000);
				this.totalTime = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
			}
		}, 1000);
	}

	/** Stops the interval timer and clears the interval */
	private stopTimer() {
		if (this.timerInterval) {
			clearInterval(this.timerInterval);
			this.timerInterval = null;
		}
	}

	setPlayerName(name: string) {
		this.playerName = name;
	}

	startGame(playerName: string) {
		this.playerName = playerName;
		this.startTime = Date.now();
		this.elapsedTime = 0;
		this.isGameActive = true;

		createSession(this.playerName, this.startTime);
	}

	captureTreasure() {
		const currentTreasure = this.treasures[this.currentTreasureIndex];
		currentTreasure.found = true;
		currentTreasure.capturedAt = Date.now();
		goto('/capture-success');
	}

	nextTreasure() {
		const nextIndex = this.currentTreasureIndex + 1;

		// Check if all treasures are found
		if (nextIndex >= this.treasures.length) {
			this.isGameActive = false;
			goto('/clue'); // Will show completion in Phase 2
			return;
		}

		this.currentTreasureIndex = nextIndex;
		goto('/clue');
	}

	resetGame() {
		this.stopTimer();
		if (this.unsubscribeOnlineStatus) {
			this.unsubscribeOnlineStatus();
			this.unsubscribeOnlineStatus = null;
		}
		goto('/name-entry');
		this.playerName = '';
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
