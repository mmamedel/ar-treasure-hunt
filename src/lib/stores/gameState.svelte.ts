import { goto } from '$app/navigation';
import { getContext, setContext } from 'svelte';
import {
	createSession,
	setSessionCurrentTreasureIndex,
	setSessionGameFinished,
	updateSessionTreasures,
	type Question
} from './gameSessionPersisted';
import { onOnlineStatusChange } from '../offline';

export interface GameStateProps {
	playerName: string;
	startTime: number;
	endTime?: number;
	isFinished: boolean;
	currentTreasureIndex: number;
	treasuresData: Question[];
}

export interface Treasure {
	id: number;
	emoji: string;
	name: string;
	clue: string;
	markerId: string;
	markerType: 'kanji' | 'hiro';
	found: boolean;
	start?: number;
	capturedAt?: number;
}

export const initialTreasures: Treasure[] = [
	{
		id: 0,
		emoji: '📚',
		name: 'Ministério de Jesus',
		clue: 'Durante seu ministério, Jesus curou um homem que esperava por um milagre há 38 anos. Onde ele foi?',
		markerId: 'marker-1',
		markerType: 'kanji',
		found: false
	},
	{
		id: 1,
		emoji: '🎨',
		name: 'Paleta das Cores',
		clue: 'No lugar onde a criatividade ganha vida, encontre o arco-íris escondido.',
		markerId: 'marker-2',
		markerType: 'kanji',
		found: false
	},
	{
		id: 2,
		emoji: '⚽',
		name: 'Bola Dourada',
		clue: 'Onde os campeões praticam seus sonhos, procure pela glória esportiva.',
		markerId: 'marker-3',
		markerType: 'kanji',
		found: false
	},
	{
		id: 3,
		emoji: '🎭',
		name: 'Máscara Misteriosa',
		clue: 'No palco onde histórias ganham vida, a cortina esconde um segredo.',
		markerId: 'marker-4',
		markerType: 'hiro',
		found: false
	}
	/*{
		id: 4,
		emoji: '🔬',
		name: 'Frasco da Ciência',
		clue: 'No laboratório das descobertas, o conhecimento borbulha em segredo.',
		markerId: 'marker-5',
		markerType: 'kanji',
		found: false
	},
	{
		id: 5,
		emoji: '🎵',
		name: 'Nota Musical',
		clue: 'Onde as melodias ecoam, encontre a harmonia perdida.',
		markerId: 'marker-6',
		markerType: 'hiro',
		found: false
	},
	{
		id: 6,
		emoji: '🌟',
		name: 'Estrela Brilhante',
		clue: 'No topo do mundo escolar, uma luz guia os perdidos.',
		markerId: 'marker-7',
		markerType: 'kanji',
		found: false
	} */
];

export class GameState {
	playerName: string;
	startTime: number;
	endTime?: number;
	duration?: string;
	elapsedTime = $state(0);
	currentTreasureIndex: number;
	treasures = $state<Treasure[]>([...initialTreasures]);
	elapsedTimeCode = $state('00:00');
	isGameActive: boolean;
	isOnline = $state(true);
	unsubscribeOnlineStatus: (() => void) | null = null;

	private timerInterval: ReturnType<typeof setInterval> | null = null;

	constructor(props?: GameStateProps) {
		this.playerName = $state(props?.playerName || '');
		this.startTime = $state(props?.startTime || 0);
		this.endTime = $state(props?.endTime);

		let elapsedTime = 0;
		if ((props?.isFinished, props?.endTime)) {
			elapsedTime = props.endTime - props.startTime;
			console.log(props.endTime, props.startTime, elapsedTime, this.formatTime(elapsedTime));
		}
		this.duration = $state(this.formatTime(elapsedTime));

		this.currentTreasureIndex = $state(props?.currentTreasureIndex || 0);
		this.isGameActive = $state(!!props || false);

		// Update treasures infomation based on what was stored in local storage
		for (const treasure of this.treasures) {
			const storedTreasure = props?.treasuresData.find((data) => data.id === treasure.id);

			treasure.start = storedTreasure?.start;
			treasure.capturedAt = storedTreasure?.end;
			treasure.found = storedTreasure?.found || false;
		}

		// Start/stop the timer based on game active state
		$effect(() => {
			if (this.isGameActive && this.startTime > 0 && !props?.isFinished) {
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

	private formatTime(time: number) {
		const minutes = Math.floor(time / 60000);
		const seconds = Math.floor((time % 60000) / 1000);
		return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
	}

	/** Starts the interval timer that updates every second for live UI display */
	private startTimer() {
		if (this.timerInterval) return;

		this.timerInterval = setInterval(() => {
			if (this.startTime > 0 && this.isGameActive) {
				this.elapsedTime = Date.now() - this.startTime;
				this.elapsedTimeCode = this.formatTime(this.elapsedTime);
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

		this.treasures[this.currentTreasureIndex].start = this.startTime;

		createSession(this.playerName, this.startTime, this.treasures);
	}

	captureTreasure() {
		const currentTreasure = this.treasures[this.currentTreasureIndex];
		currentTreasure.found = true;
		currentTreasure.capturedAt = Date.now();

		updateSessionTreasures(currentTreasure);

		// Check if all treasures are found
		const nextIndex = this.currentTreasureIndex + 1;
		if (nextIndex >= this.treasures.length) {
			this.isGameActive = false;
			this.stopTimer();
			setSessionGameFinished(currentTreasure.capturedAt);
		}

		goto('/');
	}

	nextTreasure() {
		const nextIndex = this.currentTreasureIndex + 1;
		this.currentTreasureIndex = nextIndex;
		this.treasures[this.currentTreasureIndex].start = Date.now();

		setSessionCurrentTreasureIndex(nextIndex);
		updateSessionTreasures(this.treasures[this.currentTreasureIndex]);
	}

	get isFinished() {
		return this.treasures.filter((treasure) => treasure.found).length === initialTreasures.length;
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
