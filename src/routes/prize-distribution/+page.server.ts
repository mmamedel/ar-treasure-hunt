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
		throw error(400, 'playerName query parameter is required');
	}

	if (typeof playerName !== 'string' || playerName.trim().length === 0) {
		throw error(400, 'playerName must be a non-empty string');
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
				message: 'Player not found in the system.',
				startTime: undefined,
				endTime: undefined
			};
			return { prizeStatus };
		}

		let eligibleForPrize = false;
		let message = '';

		if (!gameSession.hasFinished) {
			message = 'This player has not finished the game yet and is not eligible to receive a prize.';
		} else if (gameSession.hasReceivedPrize) {
			message = 'This player has already received their prize.';
		} else {
			eligibleForPrize = true;
			message = 'This player has completed the game and is eligible to receive a prize!';
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
		throw error(500, 'Failed to fetch player information');
	}
};
