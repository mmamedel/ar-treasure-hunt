import type { PageServerLoad } from './$types';
import staticLeaderboardData from '$lib/data/leaderboard-static.json';

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

function loadStaticLeaderboard(): LeaderboardEntry[] {
	// Convert the static JSON data to match the LeaderboardEntry interface
	return staticLeaderboardData.map((entry: any) => ({
		rank: entry.rank,
		playerName: entry.playerName,
		startTime: new Date(entry.startTime),
		endTime: new Date(entry.endTime),
		duration: entry.duration,
		durationFormatted: entry.durationFormatted
	}));
}

// ORIGINAL DATABASE CODE - preserved for future treasure hunts
// Uncomment this function and comment out loadStaticLeaderboard() to restore database functionality
/*
import { error } from '@sveltejs/kit';
import prisma from '$lib/prisma';

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

async function fetchLeaderboard(): Promise<LeaderboardEntry[]> {
	try {
		// Get all finished game sessions sorted by durationMs (ascending)
		const allFinishedSessions = await (
			prisma.gameSession.findMany as unknown as (args: {
				where: { hasFinished: boolean };
				orderBy: { durationMs: 'asc' };
				take: number;
			}) => Promise<
				Array<{
					playerName: string;
					nameOverride: string | null;
					start: Date;
					end: Date | null;
					durationMs: number | null;
				}>
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
				playerName: session.nameOverride ?? session.playerName,
				startTime: session.start,
				endTime: session.end!,
				duration: session.durationMs!,
				durationFormatted: formatDuration(session.durationMs!)
			}));

		return top100;
	} catch (err) {
		console.error('Error fetching leaderboard:', err);
		throw error(500, 'Failed to fetch leaderboard data');
	}
}
*/

export const load: PageServerLoad = async () => {
	return {
		// Return the static leaderboard data
		top100: loadStaticLeaderboard()
	};
};
