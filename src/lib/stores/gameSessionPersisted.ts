import { PersistedState } from 'runed';
import { createGameState, getGameState } from './gameState.svelte';

const GAME_SSESION_KEY = 'GameSession ';

export interface Question {
	id: string;
	questionNumber: number;
	start?: number;
	end?: number;
}

export interface GameSession {
	id: string;
	playerName: string;
	start: number;
	end?: number;
	questions: Question[];
}

export function loadSession() {
	const session = new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, undefined);

	if (session.current?.id) {
		return createGameState({
			playerName: session.current.playerName,
			startTime: session.current.start,
			currentTreasureIndex: 0
		});
	} else {
		return createGameState();
	}
}

export function createSession(name: string, startTime: number) {
	return new PersistedState<GameSession | undefined>(GAME_SSESION_KEY, {
		id: 'random-id',
		playerName: name,
		start: startTime,
		questions: []
	});
}
