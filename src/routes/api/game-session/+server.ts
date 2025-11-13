import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

interface CreateGameSessionRequest {
	playerName: string;
	startTime: number;
}

interface ErrorResponse {
	error: string;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as CreateGameSessionRequest;
		const { playerName, startTime } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			const errorResponse: ErrorResponse = { error: 'playerName is required and must be a string' };
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName cannot be empty' };
			return json(errorResponse, { status: 400 });
		}

		// Validate startTime (required)
		if (startTime === undefined || startTime === null) {
			const errorResponse: ErrorResponse = { error: 'startTime is required' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof startTime !== 'number') {
			const errorResponse: ErrorResponse = { error: 'startTime must be a number' };
			return json(errorResponse, { status: 400 });
		}

		if (startTime <= 0) {
			const errorResponse: ErrorResponse = { error: 'startTime must be a positive number' };
			return json(errorResponse, { status: 400 });
		}

		// Create the game session
		// Note: Prisma will handle uniqueness constraint violation
		const gameSession = await prisma.gameSession.create({
			data: {
				playerName: playerName.trim(),
				start: new Date(startTime)
			}
		});

		return json(gameSession, { status: 201 });
	} catch (error) {
		console.error('Error creating game session:', error);

		// Handle unique constraint violation
		if (error instanceof Error && error.message.includes('Unique constraint')) {
			const errorResponse: ErrorResponse = { error: 'Player name already exists' };
			return json(errorResponse, { status: 409 });
		}

		const errorResponse: ErrorResponse = { error: 'Failed to create game session' };
		return json(errorResponse, { status: 500 });
	}
};
