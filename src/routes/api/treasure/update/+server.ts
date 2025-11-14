import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

interface UpdateTreasureRequest {
	playerName: string;
	treasureId: number;
	start: number;
	end?: number;
}

interface ErrorResponse {
	error: string;
}

interface SuccessResponse {
	message: string;
	treasureId: number;
	found: boolean;
}

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = (await request.json()) as UpdateTreasureRequest;
		const { playerName, treasureId, start, end } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			const errorResponse: ErrorResponse = { error: 'playerName is required and must be a string' };
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName cannot be empty' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof treasureId !== 'number') {
			const errorResponse: ErrorResponse = { error: 'treasureId must be a number' };
			return json(errorResponse, { status: 400 });
		}

		if (typeof start !== 'number' || start <= 0) {
			const errorResponse: ErrorResponse = { error: 'start must be a positive number (timestamp)' };
			return json(errorResponse, { status: 400 });
		}

		if (end) {
			if (typeof end !== 'number' || end <= 0) {
				const errorResponse: ErrorResponse = { error: 'end must be a positive number (timestamp)' };
				return json(errorResponse, { status: 400 });
			}

			if (end < start) {
				const errorResponse: ErrorResponse = { error: 'end time cannot be before start time' };
				return json(errorResponse, { status: 400 });
			}
		}

		// Update the treasure
		const updatedTreasure = await prisma.treasure.updateMany({
			where: {
				gameSession: {
					playerName
				},
				treasureNumber: treasureId
			},
			data: {
				start: new Date(start),
				end: end ? new Date(end) : undefined,
				found: true
			}
		});

		if (updatedTreasure.count === 0) {
			const errorResponse: ErrorResponse = { error: 'Treasure or game session not found' };
			return json(errorResponse, { status: 404 });
		}

		const successResponse: SuccessResponse = {
			message: 'Treasure updated successfully',
			treasureId,
			found: true
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error updating treasure:', error);

		const errorResponse: ErrorResponse = { error: 'Failed to update treasure' };
		return json(errorResponse, { status: 500 });
	}
};
