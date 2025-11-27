import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import prisma from '$lib/prisma';
import { withAdminApiPermission } from '$lib/config/admin';

export const GET: RequestHandler = withAdminApiPermission(async ({ url }) => {
	try {
		const query = url.searchParams.get('q');

		if (!query) {
			return json({ error: 'Query parameter "q" is required' }, { status: 400 });
		}

		// Search for sessions where playerName contains the query (case-insensitive)
		const sessions = await prisma.gameSession.findMany({
			where: {
				playerName: {
					contains: query,
					mode: 'insensitive'
				}
			},
			orderBy: {
				start: 'desc'
			},
			take: 20,
			select: {
				id: true,
				playerName: true,
				nameOverride: true,
				start: true,
				end: true,
				hasFinished: true,
				durationMs: true
			}
		});

		return json({
			success: true,
			sessions: sessions.map((session) => ({
				id: session.id,
				playerName: session.playerName,
				nameOverride: session.nameOverride,
				displayName: session.nameOverride ?? session.playerName,
				start: session.start.toISOString(),
				end: session.end?.toISOString() ?? null,
				hasFinished: session.hasFinished,
				durationMs: session.durationMs
			}))
		});
	} catch (error) {
		console.error('Error searching sessions:', error);
		return json({ error: 'Erro ao buscar sessões' }, { status: 500 });
	}
});
