import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = await request.json();
		const { playerName } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			return json({ error: 'playerName is required and must be a string' }, { status: 400 });
		}

		const trimmedName = playerName.trim();

		// Basic validation (2-20 characters)
		if (trimmedName.length < 2 || trimmedName.length > 20) {
			return json(
				{
					available: false,
					reason: 'Name must be between 2 and 20 characters'
				},
				{ status: 200 }
			);
		}

		// Check if name already exists in database
		const result = await prisma.gameSession.count({
			where: { playerName: { equals: trimmedName, mode: 'insensitive' } }
		});

		const available = result === 0;

		return json({
			available,
			reason: available ? 'Name is available' : 'Name is already taken'
		});
	} catch (error) {
		console.error('Error checking player name:', error);
		return json({ error: 'Failed to check player name validity' }, { status: 500 });
	}
};
