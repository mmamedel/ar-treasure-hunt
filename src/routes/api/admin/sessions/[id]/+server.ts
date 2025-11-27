import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import prisma from '$lib/prisma';
import { withAdminApiPermission } from '$lib/config/admin';

export const PATCH: RequestHandler = withAdminApiPermission(async ({ params, request }) => {
	try {
		const sessionId = parseInt(params.id);

		if (isNaN(sessionId)) {
			return json({ error: 'ID de sessão inválido' }, { status: 400 });
		}

		const { nameOverride } = await request.json();

		// Allow null or string values
		if (nameOverride !== null && typeof nameOverride !== 'string') {
			return json({ error: 'nameOverride deve ser string ou null' }, { status: 400 });
		}

		// Update the session
		const updatedSession = await prisma.gameSession.update({
			where: { id: sessionId },
			data: { nameOverride },
			select: {
				id: true,
				playerName: true,
				nameOverride: true,
				start: true,
				end: true,
				hasFinished: true
			}
		});

		return json({
			success: true,
			session: {
				id: updatedSession.id,
				playerName: updatedSession.playerName,
				nameOverride: updatedSession.nameOverride,
				displayName: updatedSession.nameOverride ?? updatedSession.playerName,
				start: updatedSession.start.toISOString(),
				end: updatedSession.end?.toISOString() ?? null,
				hasFinished: updatedSession.hasFinished
			}
		});
	} catch (error: any) {
		console.error('Error updating session:', error);

		if (error.code === 'P2025') {
			return json({ error: 'Sessão não encontrada' }, { status: 404 });
		}

		return json({ error: 'Erro ao atualizar sessão' }, { status: 500 });
	}
});
