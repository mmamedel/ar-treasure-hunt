import { json } from '@sveltejs/kit';
import type { RequestHandler } from '@sveltejs/kit';
import prisma from '$lib/prisma';

export const POST: RequestHandler = async ({ request }) => {
	try {
		const body = await request.json();
		const { playerName } = body;

		// Validate input
		if (!playerName || typeof playerName !== 'string') {
			return json(
				{ error: 'Nome do jogador é obrigatório e deve ser uma string' },
				{ status: 400 }
			);
		}

		const trimmedName = playerName.trim();

		// Basic validation (2-20 characters)
		if (trimmedName.length < 2 || trimmedName.length > 20) {
			return json(
				{
					available: false,
					reason: 'Nome deve ter entre 2 e 20 caracteres'
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
			reason: available ? 'Nome disponível' : 'Nome já está em uso'
		});
	} catch (error) {
		console.error('Error checking player name:', error);
		return json({ error: 'Falha ao verificar validade do nome' }, { status: 500 });
	}
};
