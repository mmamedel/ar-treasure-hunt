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
			const errorResponse: ErrorResponse = {
				error: 'playerName é obrigatório e deve ser uma string'
			};
			return json(errorResponse, { status: 400 });
		}

		if (playerName.trim().length === 0) {
			const errorResponse: ErrorResponse = { error: 'playerName não pode estar vazio' };
			return json(errorResponse, { status: 400 });
		}

		// Find the game session
		const gameSession = await (
			prisma.gameSession.findUnique as unknown as (args: {
				where: { playerName: string };
			}) => Promise<{ id: number; hasFinished: boolean; hasReceivedPrize: boolean } | null>
		)({
			where: { playerName: playerName.trim() }
		});

		if (!gameSession) {
			const errorResponse: ErrorResponse = { error: 'Sessão de jogo não encontrada' };
			return json(errorResponse, { status: 404 });
		}

		// Check if game is finished
		if (!gameSession.hasFinished) {
			const errorResponse: ErrorResponse = {
				error: 'Jogador ainda não finalizou o jogo'
			};
			return json(errorResponse, { status: 400 });
		}

		// Check if prize already received
		if (gameSession.hasReceivedPrize) {
			const errorResponse: ErrorResponse = { error: 'Prêmio já foi entregue para este jogador' };
			return json(errorResponse, { status: 400 });
		}

		// Update game session to mark prize as received
		const updatedSession = await (
			prisma.gameSession.update as unknown as (args: {
				where: { playerName: string };
				data: { hasReceivedPrize: boolean };
			}) => Promise<{ hasReceivedPrize: boolean }>
		)({
			where: { playerName: playerName.trim() },
			data: {
				hasReceivedPrize: true
			}
		});

		const successResponse: SuccessResponse = {
			message: 'Prêmio marcado como entregue com sucesso',
			hasReceivedPrize: updatedSession.hasReceivedPrize
		};

		return json(successResponse, { status: 200 });
	} catch (error) {
		console.error('Error marking prize as delivered:', error);

		const errorResponse: ErrorResponse = { error: 'Falha ao marcar prêmio como entregue' };
		return json(errorResponse, { status: 500 });
	}
};
