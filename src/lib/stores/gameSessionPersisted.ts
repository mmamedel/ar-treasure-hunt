import { PersistedState } from 'runed';
import { createGameState, type Treasure } from './gameState.svelte';

const GAME_SSESION_KEY = 'GameSession ';

export interface Question {
	id: number;
	start?: number;
	end?: number;
}

export interface GameSession {
	playerName: string;
	start: number;
	end?: number;
	questions: Question[];
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
			currentTreasureIndex: 0 // TODO calculate what treasure the user is based on what is in the local storage
		});
	} else {
		return createGameState();
	}
}

export async function createSession(name: string, startTime: number, startTreasure: Treasure) {
	new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, {
		playerName: name,
		start: startTime,
		questions: [
			{
				id: startTreasure.id,
				start: startTreasure.start,
				end: startTreasure.capturedAt
			}
		]
	});

	// Create Session in DB via API (server-side)
	try {
		const response = await fetch('/api/game-session', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ playerName: name, startTime })
		});

		if (!response.ok) {
			const error = await response.json();
			console.error('Failed to create game session:', error);
		}
	} catch (error) {
		console.error('Failed to create game session', error);
	}
}

export function addTreasure(treasure: Treasure) {
	const session = getSession();
	session.current?.questions.push({
		id: treasure.id,
		start: treasure.start,
		end: treasure.capturedAt
	});

	// TODO Update DB
}

export function updateTreasures(treasure: Treasure) {
	const session = getSession();

	const foundTreasure = session.current?.questions.find(
		(storedTreasure) => storedTreasure.id === treasure.id
	);

	if (!foundTreasure) {
		console.warn('Treasure not found in the localStorage. Adding it.');
		session.current?.questions.push({
			id: treasure.id,
			start: treasure.start,
			end: treasure.capturedAt
		});
	} else {
		foundTreasure.end = treasure.capturedAt;
	}

	// TODO Update DB
}
