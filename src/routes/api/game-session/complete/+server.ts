import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import type { SessionTreasure } from '$lib/stores/gameSessionPersisted';

interface UpdateGameSessionRequest {
	playerName: string;
	treasures: SessionTreasure[]; // Only used for validating if the user has found all treasures
	startTime: number;
	endTime: number;
}

interface ErrorResponse {
	error: string;
}

interface SuccessResponse {
	message: string;
	hasFinished: boolean;
	allTreasuresFound: boolean;
	durationMs: number;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as UpdateGameSessionRequest;
		const { playerName, treasures, startTime, endTime } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			const errorResponse: ErrorResponse = { error: 'playerName is required and must be a string' };
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName cannot be empty' };
			return json(errorResponse, { status: 400 });
		}

		if (!Array.isArray(treasures)) {
			const errorResponse: ErrorResponse = { error: 'treasures must be an array' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof startTime !== 'number' || startTime <= 0) {
			const errorResponse: ErrorResponse = { error: 'startTime must be a positive number' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof endTime !== 'number' || endTime <= 0) {
			const errorResponse: ErrorResponse = { error: 'endTime must be a positive number' };
			return json(errorResponse, { status: 400 });
		}

		if (endTime < startTime) {
			const errorResponse: ErrorResponse = { error: 'endTime cannot be before startTime' };
			return json(errorResponse, { status: 400 });
		}

		// Validate all treasures have the required fields
		const allTreasuresComplete = treasures.every(
			(treasure) => treasure.end && treasure.found === true
		);

		if (!allTreasuresComplete) {
			const errorResponse: ErrorResponse = {
				error: 'You must complete the game first'
			};
			return json(errorResponse, { status: 400 });
		}

		// Calculate duration (end - start) in milliseconds
		const startDate = new Date(startTime);
		const endDate = new Date(endTime);
		const durationMs = endDate.getTime() - startDate.getTime();

		// Update game session as finished
		const updatedSession = await prisma.gameSession.update({
			where: { playerName: playerName.trim() },
			data: {
				hasFinished: true,
				start: startDate,
				end: endDate,
				durationMs: durationMs
			}
		});

		const successResponse: SuccessResponse = {
			message: 'Game session completed successfully',
			hasFinished: updatedSession.hasFinished,
			allTreasuresFound: allTreasuresComplete,
			durationMs: durationMs
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error updating game session:', error);

		const errorResponse: ErrorResponse = { error: 'Failed to update game session' };
		return json(errorResponse, { status: 500 });
	}
};
