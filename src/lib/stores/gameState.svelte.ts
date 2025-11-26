import { getContext, setContext } from 'svelte';
import treasuresData from '../data/treasures.json';
import { onOnlineStatusChange } from '../offline';
import {
	createSession,
	setSessionCurrentTreasureIndex,
	updateSessionTreasures,
	type SessionTreasure
} from './gameSessionPersisted';

export interface GameStateProps {
	playerName: string;
	startTime: number;
	endTime?: number;
	isFinished: boolean;
	currentTreasureIndex: number;
	treasuresData: SessionTreasure[];
	reverse?: boolean;
}

export interface Treasure {
	id: number;
	emoji: string;
	name: string;
	clue: string;
	hint: string;
	model: {
		file: string;
		scale: string;
		rotation: string;
		position: string;
	};
	found: boolean;
	start?: number;
	end?: number;
}

export const initialTreasures = treasuresData satisfies Treasure[];

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
	reverse: boolean = false; // If true, treasure order is: first + reversed rest (e.g., 1,6,5,4,3,2)
	unsubscribeOnlineStatus: (() => void) | null = null;

	private timerInterval: ReturnType<typeof setInterval> | null = null;

	constructor(props?: GameStateProps) {
		this.playerName = $state(props?.playerName || '');
		this.startTime = $state(props?.startTime || 0);
		this.endTime = $state(props?.endTime);

		// Set reverse: use saved value if available, otherwise randomly choose
		this.reverse = props?.reverse !== undefined ? props.reverse : Math.random() < 0.5;

		let elapsedTime = 0;
		if ((props?.isFinished, props?.endTime)) {
			elapsedTime = props.endTime - props.startTime;
		}
		this.duration = $state(this.formatTime(elapsedTime));

		this.currentTreasureIndex = $state(props?.currentTreasureIndex || 0);
		this.isGameActive = $state(!!props || false);

		// Restore treasures in the correct order from session
		if (props?.treasuresData) {
			// Reconstruct treasures array in the same order as stored in session
			this.treasures = props.treasuresData.map((storedTreasure) => {
				const fullTreasure = initialTreasures.find((t) => t.id === storedTreasure.id);
				if (!fullTreasure) {
					throw new Error(`Treasure with id ${storedTreasure.id} not found`);
				}
				return {
					...fullTreasure,
					start: storedTreasure.start,
					end: storedTreasure.end,
					found: storedTreasure.found
				};
			});
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

	setTreasureOrder(reverse: boolean) {
		this.reverse = reverse;

		// Reset treasures to initial state
		this.treasures = [...initialTreasures].map((t) => ({
			...t,
			found: false,
			start: undefined,
			end: undefined
		}));

		if (reverse) {
			// Keep first treasure, reverse the rest: [0, 5, 4, 3, 2, 1]
			const first = this.treasures[0];
			const rest = this.treasures.slice(1).reverse();
			this.treasures = [first, ...rest];
		}
	}

	startGame(playerName: string) {
		this.playerName = playerName;
		this.startTime = Date.now();
		this.elapsedTimeClock = 0;
		this.isGameActive = true;

		// Apply treasure order based on reverse flag
		this.setTreasureOrder(this.reverse);

		this.treasures[this.currentTreasureIndex].start = this.startTime;

		createSession(this.playerName, this.startTime, this.treasures, this.reverse);
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
