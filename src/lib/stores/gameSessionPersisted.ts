import { PersistedState } from 'runed';
import { createGameState, type Treasure } from './gameState.svelte';

const GAME_SSESION_KEY = 'GameSession ';

export interface SessionTreasure {
	id: number;
	start?: number;
	end?: number;
	found: boolean;
}

export interface GameSession {
	playerName: string;
	start: number;
	end?: number;
	treasures: SessionTreasure[];
	currentTreasureIndex: number;
	isFinished: boolean;
}

export function getSession() {
	return new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, undefined);
}

export function loadSession() {
	const session = getSession();

	if (session.current?.playerName) {
		// TODO: Sync local session to DB

		return createGameState({
			playerName: session.current.playerName,
			startTime: session.current.start,
			endTime: session.current.end,
			currentTreasureIndex: session.current.currentTreasureIndex,
			treasuresData: session.current.treasures,
			isFinished: session.current.isFinished
		});
	} else {
		return createGameState();
	}
}

export async function createSession(name: string, startTime: number, treasures: Treasure[]) {
	const allTreasures = treasures.map((treasure) => ({
		id: treasure.id,
		start: treasure.start,
		end: treasure.capturedAt,
		found: treasure.found
	}));

	new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, {
		playerName: name,
		start: startTime,
		treasures: allTreasures,
		currentTreasureIndex: 0,
		isFinished: false
	});

	// Create Session in DB via API (server-side)
	try {
		const response = await fetch('/api/game-session', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				playerName: name,
				startTime,
				treasures,
				currentTreasureIndex: 0,
				isFinished: false
			})
		});

		if (!response.ok) {
			const error = await response.json();
			console.error('Failed to create game session:', error);
		}
	} catch (error) {
		console.error('Failed to create game session', error);
	}
}

export function setSessionCurrentTreasureIndex(index: number) {
	const session = getSession();

	if (session.current) {
		session.current.currentTreasureIndex = index;
	} else {
		throw new Error('session was not defined when setting current treasure index');
	}

	// TODO Update DB
}

export function updateSessionTreasures(treasure: Treasure) {
	const session = getSession();

	const storedTreasure = session.current?.treasures.find(
		(storedTreasure) => storedTreasure.id === treasure.id
	);

	if (!storedTreasure) {
		console.error('Treasure not found', JSON.stringify(treasure));
		throw new Error('Treasure not found in the localStorage');
	} else {
		storedTreasure.start = treasure.start;
		storedTreasure.end = treasure.capturedAt;
		storedTreasure.found = treasure.found;
	}

	// TODO Update DB
}

export function setSessionGameFinished(endTime: number) {
	const session = getSession();

	if (session.current) {
		session.current.isFinished = true;
		session.current.end = endTime;
	} else {
		throw new Error('session was not defined when setting game finished');
	}

	// TODO Update DB
}

export function clearGameSession() {
	try {
		const session = getSession();
		session.current = undefined;
		localStorage.removeItem(GAME_SSESION_KEY);
		console.log('Game session cleared from localStorage');
	} catch (error) {
		console.error('Failed to clear game session:', error);
	}
}
