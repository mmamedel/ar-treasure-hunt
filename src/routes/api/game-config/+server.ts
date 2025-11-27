import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import prisma from '$lib/prisma';

export const GET: RequestHandler = async () => {
	try {
		// Get the game config (there should only be one)
		const config = await prisma.gameConfig.findFirst();

		if (!config) {
			return json({
				exists: false,
				status: 'no_config',
				message: 'Nenhuma configuração de jogo encontrada'
			});
		}

		const now = new Date();
		const startTime = new Date(config.startTime);
		const endTime = new Date(config.endTime);

		let status: 'before_start' | 'active' | 'ended';
		let message: string;
		let timeUntilStart: number | null = null;

		if (now < startTime) {
			status = 'before_start';
			timeUntilStart = startTime.getTime() - now.getTime();
			message = 'O jogo ainda não começou';
		} else if (now >= startTime && now <= endTime) {
			status = 'active';
			message = 'O jogo está ativo';
		} else {
			status = 'ended';
			message = 'O jogo já terminou';
		}

		return json({
			exists: true,
			status,
			message,
			startTime: config.startTime,
			endTime: config.endTime,
			timeUntilStart
		});
	} catch (error) {
		console.error('Erro ao buscar configuração do jogo:', error);
		return json(
			{
				error: 'Erro ao buscar configuração do jogo'
			},
			{ status: 500 }
		);
	}
};
