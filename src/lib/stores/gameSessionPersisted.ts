import { PersistedState } from 'runed';
import { createGameState, type Treasure } from './gameState.svelte';
import { createDBSession } from '$lib/db/client';

const GAME_SSESION_KEY = 'GameSession';

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
	sync: boolean;
}

export function getSession() {
	return new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, undefined);
}

export function loadSession() {
	const session = getSession();

	if (session.current?.playerName) {
		// TODO: Sync local session to DB in case session creation has failed

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
		end: treasure.end,
		found: treasure.found
	}));

	const session = new PersistedState<GameSession>(GAME_SSESION_KEY, {
		playerName: name,
		start: startTime,
		treasures: allTreasures,
		currentTreasureIndex: 0,
		isFinished: false,
		sync: false
	});

	try {
		await createDBSession(name, startTime, treasures);
		session.current.sync = true;
	} catch (error) {
		console.error('Failed to create Session in DB', error);
	}
}

export async function updateSessionTreasures(treasure: Treasure) {
	const session = getSession();

	if (!session.current) {
		throw new Error('Session not found');
	}

	const storedTreasure = session.current.treasures.find(
		(storedTreasure) => storedTreasure.id === treasure.id
	);

	if (!storedTreasure) {
		console.error('Treasure not found', JSON.stringify(treasure));
		throw new Error('Treasure not found in the localStorage');
	} else {
		storedTreasure.start = treasure.start;
		storedTreasure.end = treasure.end;
		storedTreasure.found = treasure.found;
	}
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
