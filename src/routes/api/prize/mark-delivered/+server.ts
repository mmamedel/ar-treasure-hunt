import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

interface MarkPrizeRequest {
	playerName: string;
}

interface ErrorResponse {
	error: string;
}

interface SuccessResponse {
	message: string;
	hasReceivedPrize: boolean;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as MarkPrizeRequest;
		const { playerName } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			const errorResponse: ErrorResponse = { error: 'playerName is required and must be a string' };
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName cannot be empty' };
			return json(errorResponse, { status: 400 });
		}

		// Find the game session
		const gameSession = await (prisma.gameSession.findUnique as unknown as (args: {
			where: { playerName: string };
		}) => Promise<{ id: number; hasFinished: boolean; hasReceivedPrize: boolean } | null>)({
			where: { playerName: playerName.trim() }
		});

		if (!gameSession) {
			const errorResponse: ErrorResponse = { error: 'Game session not found' };
			return json(errorResponse, { status: 404 });
		}

		// Check if game is finished
		if (!gameSession.hasFinished) {
			const errorResponse: ErrorResponse = {
				error: 'Player has not finished the game yet'
			};
			return json(errorResponse, { status: 400 });
		}

		// Check if prize already received
		if (gameSession.hasReceivedPrize) {
			const errorResponse: ErrorResponse = { error: 'Prize has already been delivered to this player' };
			return json(errorResponse, { status: 400 });
		}

		// Update game session to mark prize as received
		const updatedSession = await (prisma.gameSession.update as unknown as (args: {
			where: { playerName: string };
			data: { hasReceivedPrize: boolean };
		}) => Promise<{ hasReceivedPrize: boolean }>)({
			where: { playerName: playerName.trim() },
			data: {
				hasReceivedPrize: true
			}
		});

		const successResponse: SuccessResponse = {
			message: 'Prize marked as delivered successfully',
			hasReceivedPrize: updatedSession.hasReceivedPrize
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error marking prize as delivered:', error);

		const errorResponse: ErrorResponse = { error: 'Failed to mark prize as delivered' };
		return json(errorResponse, { status: 500 });
	}
};
