import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import prisma from '$lib/prisma';

export interface PrizeStatus {
	playerName: string;
	isFinished: boolean;
	hasReceivedPrize: boolean;
	eligibleForPrize: boolean;
	message: string;
	startTime?: Date;
	endTime?: Date;
}

export const load: PageServerLoad = async ({ url }) => {
	const playerName = url.searchParams.get('playerName');

	if (!playerName) {
		throw error(400, 'O parâmetro playerName é obrigatório');
	}

	if (typeof playerName !== 'string' || playerName.trim().length === 0) {
		throw error(400, 'playerName deve ser uma string não vazia');
	}

	try {
		const gameSession = await (
			prisma.gameSession.findUnique as unknown as (args: {
				where: { playerName: string };
			}) => Promise<{
				playerName: string;
				hasFinished: boolean;
				hasReceivedPrize: boolean;
				start: Date;
				end: Date | null;
			} | null>
		)({
			where: { playerName: playerName.trim() }
		});

		if (!gameSession) {
			const prizeStatus: PrizeStatus = {
				playerName: playerName.trim(),
				isFinished: false,
				hasReceivedPrize: false,
				eligibleForPrize: false,
				message: 'Jogador não encontrado no sistema.',
				startTime: undefined,
				endTime: undefined
			};
			return { prizeStatus };
		}

		let eligibleForPrize = false;
		let message = '';

		if (!gameSession.hasFinished) {
			message = 'Este jogador ainda não finalizou o jogo e não é elegível para receber um prêmio.';
		} else if (gameSession.hasReceivedPrize) {
			message = 'Este jogador já recebeu seu prêmio.';
		} else {
			eligibleForPrize = true;
			message = 'Este jogador completou o jogo e está elegível para receber um prêmio!';
		}

		const prizeStatus: PrizeStatus = {
			playerName: gameSession.playerName,
			isFinished: gameSession.hasFinished,
			hasReceivedPrize: gameSession.hasReceivedPrize,
			eligibleForPrize,
			message,
			startTime: gameSession.start,
			endTime: gameSession.end ?? undefined
		};

		return { prizeStatus };
	} catch (err) {
		console.error('Error fetching game session:', err);
		throw error(500, 'Falha ao buscar informações do jogador');
	}
};
