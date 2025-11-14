import { goto } from '$app/navigation';
import { getContext, setContext } from 'svelte';
import {
	createSession,
	setSessionCurrentTreasureIndex,
	setSessionGameFinished,
	updateSessionTreasures,
	type SessionTreasure
} from './gameSessionPersisted';
import { onOnlineStatusChange } from '../offline';

export interface GameStateProps {
	playerName: string;
	startTime: number;
	endTime?: number;
	isFinished: boolean;
	currentTreasureIndex: number;
	treasuresData: SessionTreasure[];
}

export interface Treasure {
	id: number;
	emoji: string;
	name: string;
	clue: string;
	hint: string;
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
		name: 'Piscina (Batismo de Jesus)',
		clue: 'Um homem vestido de camelo chamou as pessoas para se arrependerem. Aqui ele mergulhou o maior de todos.',
		hint: 'Procure onde a água é funda o bastante para descer e subir, como no Jordão.',
		markerId: 'marker-1',
		markerType: 'kanji',
		found: false
	},
	{
		id: 1,
		emoji: '🎨',
		name: 'Lava-olho (cura do cego – João 9:6,7)',
		clue: 'Um homem recebeu barro nos olhos e, depois de lavar, viu o mundo pela primeira vez.',
		hint: 'Veja onde as pessoas limpam os olhos de verdade. Lá está a marca',
		markerId: 'marker-2',
		markerType: 'kanji',
		found: false
	},
	{
		id: 2,
		emoji: '⚽',
		name: ' Torneira (samaritana no poço – João 4:6-15)',
		clue: 'Uma mulher foi buscar água e encontrou algo melhor: água que dá vida eterna.',
		hint: 'Procure onde a água jorra facilmente, como num pequeno poço moderno',
		markerId: 'marker-3',
		markerType: 'kanji',
		found: false
	},
	{
		id: 3,
		emoji: '🎭',
		name: 'Mirante (tentação no alto monte – Mateus 4:8)',
		clue: 'De um lugar alto, alguém viu todos os reinos da terra em um instante.',
		hint: 'Olhe de onde se pode enxergar mais longe, lá você encontrará a marca.',
		markerId: 'marker-4',
		markerType: 'hiro',
		found: false
	},
	{
		id: 4,
		emoji: '🔬',
		name: 'Karaokê (Jesus e discípulos cantaram – Mateus 26:30)',
		clue: 'Depois de uma refeição sagrada, eles levantaram a voz em harmonia.',
		hint: 'Procure onde as pessoas também soltam a voz e cantam juntas.',
		markerId: 'marker-5',
		markerType: 'kanji',
		found: false
	},
	{
		id: 5,
		emoji: '🎵',
		name: 'Auditório (Jesus na sinagoga – Lucas 4:16-21)',
		clue: 'Ele abriu o rolo e leu palavras sobre boas novas para todos.',
		hint: 'Veja onde as pessoas se reúnem para ouvir alguém falar em público. Lá está a marca.',
		markerId: 'marker-6',
		markerType: 'hiro',
		found: false
	}
];

export class GameState {
	playerName: string;
	startTime: number;
	endTime?: number;
	duration?: string;
	elapsedTimeClock = $state(0);
	currentTreasureIndex: number;
	treasures = $state<Treasure[]>([...initialTreasures]);
	elapsedTimeCodeClock = $state('00:00');
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
				this.elapsedTimeClock = Date.now() - this.startTime;
				this.elapsedTimeCodeClock = this.formatTime(this.elapsedTimeClock);
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
		this.elapsedTimeClock = 0;
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
