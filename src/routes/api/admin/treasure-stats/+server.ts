import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import prisma from '$lib/prisma';
import { withAdminApiPermission } from '$lib/config/admin';

// Treasure emoji mapping
const TREASURE_EMOJIS: Record<number, string> = {
	0: '🎶',
	1: '🏛️',
	2: '🏺',
	3: '👁️',
	4: '💧',
	5: '📜'
};

export const GET: RequestHandler = withAdminApiPermission(async () => {
	try {
		// Get all treasures that have been found
		const treasures = await prisma.treasure.findMany({
			where: {
				found: true,
				end: { not: null }
			},
			select: {
				treasureNumber: true,
				start: true,
				end: true
			}
		});

		// Calculate duration for each treasure
		const treasuresWithDuration = treasures.map((treasure) => ({
			treasureNumber: treasure.treasureNumber,
			durationMs: treasure.end!.getTime() - treasure.start.getTime()
		}));

		// Group by treasure number and calculate stats
		const statsMap = new Map<
			number,
			{ durations: number[]; count: number; sum: number; min: number; max: number }
		>();

		treasuresWithDuration.forEach(({ treasureNumber, durationMs }) => {
			if (!statsMap.has(treasureNumber)) {
				statsMap.set(treasureNumber, {
					durations: [],
					count: 0,
					sum: 0,
					min: Infinity,
					max: 0
				});
			}

			const stats = statsMap.get(treasureNumber)!;
			stats.durations.push(durationMs);
			stats.count++;
			stats.sum += durationMs;
			stats.min = Math.min(stats.min, durationMs);
			stats.max = Math.max(stats.max, durationMs);
		});

		// Calculate averages and format output
		const treasureStats = Array.from(statsMap.entries())
			.map(([treasureNumber, stats]) => ({
				treasureNumber,
				emoji: TREASURE_EMOJIS[treasureNumber] || '❓',
				count: stats.count,
				averageMs: Math.round(stats.sum / stats.count),
				minMs: stats.min,
				maxMs: stats.max,
				averageFormatted: formatDuration(stats.sum / stats.count),
				minFormatted: formatDuration(stats.min),
				maxFormatted: formatDuration(stats.max)
			}))
			.sort((a, b) => a.treasureNumber - b.treasureNumber);

		return json({
			success: true,
			stats: treasureStats
		});
	} catch (error) {
		console.error('Error fetching treasure stats:', error);
		return json({ error: 'Erro ao buscar estatísticas' }, { status: 500 });
	}
});

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
