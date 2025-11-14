import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';
import type { SessionTreasure } from '$lib/stores/gameSessionPersisted';

interface UpdateGameSessionRequest {
	playerName: string;
	treasures: SessionTreasure[];
	endTime: number;
}

interface ErrorResponse {
	error: string;
}

interface SuccessResponse {
	message: string;
	hasFinished: boolean;
	allTreasuresFound: boolean;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as UpdateGameSessionRequest;
		const { playerName, treasures, endTime } = body;

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

		if (typeof endTime !== 'number' || endTime <= 0) {
			const errorResponse: ErrorResponse = { error: 'endTime must be a positive number' };
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

		// Find the game session
		const gameSession = await (
			prisma.gameSession.findUnique as unknown as (args: {
				where: { playerName: string };
			}) => Promise<{ id: number; playerName: string } | null>
		)({
			where: { playerName: playerName.trim() }
		});

		if (!gameSession) {
			const errorResponse: ErrorResponse = { error: 'Game session not found' };
			return json(errorResponse, { status: 404 });
		}

		// Update game session as finished
		const updatedSession = await prisma.gameSession.update({
			where: { playerName: playerName.trim() },
			data: {
				hasFinished: true,
				end: new Date(endTime)
			}
		});

		const successResponse: SuccessResponse = {
			message: 'Game session completed successfully',
			hasFinished: updatedSession.hasFinished,
			allTreasuresFound: allTreasuresComplete
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error updating game session:', error);

		const errorResponse: ErrorResponse = { error: 'Failed to update game session' };
		return json(errorResponse, { status: 500 });
	}
};
