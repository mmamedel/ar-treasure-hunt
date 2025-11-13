import { PersistedState } from 'runed';
import { createGameState } from './gameState.svelte';

const GAME_SSESION_KEY = 'GameSession ';

export interface Question {
	id: string;
	questionNumber: number;
	start?: number;
	end?: number;
}

export interface GameSession {
	playerName: string;
	start: number;
	end?: number;
	questions: Question[];
}

export function loadSession() {
	const session = new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, undefined);

	if (session.current?.playerName) {
		// TODO: Sync local session to DB

		return createGameState({
			playerName: session.current.playerName,
			startTime: session.current.start,
			currentTreasureIndex: 0
		});
	} else {
		return createGameState();
	}
}

export async function createSession(name: string, startTime: number) {
	new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, {
		playerName: name,
		start: startTime,
		questions: []
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
