import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

interface SetTreasureIndexRequest {
	playerName: string;
	index: number;
}

interface ErrorResponse {
	error: string;
}

interface SuccessResponse {
	message: string;
	currentTreasureIndex: number;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as SetTreasureIndexRequest;
		const { playerName, index } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			const errorResponse: ErrorResponse = { error: 'playerName is required and must be a string' };
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName cannot be empty' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof index !== 'number') {
			const errorResponse: ErrorResponse = { error: 'index must be a number' };
			return json(errorResponse, { status: 400 });
		}

		// Update the current treasure index
		const updatedSession = await prisma.gameSession.update({
			where: { playerName: playerName.trim() },
			data: {
				currentTreasureIndex: index
			}
		});

		const successResponse: SuccessResponse = {
			message: 'Current treasure index updated successfully',
			currentTreasureIndex: updatedSession.currentTreasureIndex
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error setting treasure index:', error);

		const errorResponse: ErrorResponse = { error: 'Failed to set treasure index' };
		return json(errorResponse, { status: 500 });
	}
};
