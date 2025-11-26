import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import prisma from '$lib/prisma';

export interface LeaderboardEntry {
	rank: number;
	playerName: string;
	startTime: Date;
	endTime: Date;
	duration: number; // in milliseconds
	durationFormatted: string; // formatted duration
}

export interface LeaderboardData {
	top100: LeaderboardEntry[];
}

function formatDuration(milliseconds: number): string {
	const totalSeconds = Math.floor(milliseconds / 1000);
	const hours = Math.floor(totalSeconds / 3600);
	const minutes = Math.floor((totalSeconds % 3600) / 60);
	const seconds = totalSeconds % 60;

	if (hours > 0) {
		return `${hours}h ${minutes}m ${seconds}s`;
	} else if (minutes > 0) {
		return `${minutes}m ${seconds}s`;
	} else {
		return `${seconds}s`;
	}
}

export const load: PageServerLoad = async () => {
	try {
		// Get all finished game sessions sorted by durationMs (ascending)
		const allFinishedSessions = await (
			prisma.gameSession.findMany as unknown as (args: {
				where: { hasFinished: boolean };
				orderBy: { durationMs: 'asc' };
				take: number;
			}) => Promise<
				Array<{ playerName: string; start: Date; end: Date | null; durationMs: number | null }>
			>
		)({
			where: { hasFinished: true },
			orderBy: { durationMs: 'asc' },
			take: 100
		});

		// Filter only those with duration (should be all finished sessions)
		const top100 = allFinishedSessions
			.filter((session) => session.durationMs !== null && session.end !== null)
			.map((session, index) => ({
				rank: index + 1,
				playerName: session.playerName,
				startTime: session.start,
				endTime: session.end!,
				duration: session.durationMs!,
				durationFormatted: formatDuration(session.durationMs!)
			}));

		const leaderboardData: LeaderboardData = {
			top100
		};

		return leaderboardData;
	} catch (err) {
		console.error('Error fetching leaderboard:', err);
		throw error(500, 'Failed to fetch leaderboard data');
	}
};
