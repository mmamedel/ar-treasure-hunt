import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import prisma from '$lib/prisma';
import { withAdminApiPermission } from '$lib/config/admin';

export const POST: RequestHandler = withAdminApiPermission(async ({ request }) => {
	try {
		const { startTime, endTime } = await request.json();

		if (!startTime || !endTime) {
			return json({ error: 'startTime e endTime são obrigatórios' }, { status: 400 });
		}

		const startDate = new Date(startTime);
		const endDate = new Date(endTime);

		if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
			return json({ error: 'Datas inválidas' }, { status: 400 });
		}

		if (startDate >= endDate) {
			return json({ error: 'Data de início deve ser anterior à data de fim' }, { status: 400 });
		}

		// Upsert game config
		const config = await prisma.gameConfig.upsert({
			where: { id: 1 },
			update: {
				startTime: startDate,
				endTime: endDate
			},
			create: {
				id: 1,
				startTime: startDate,
				endTime: endDate
			}
		});

		return json({
			success: true,
			config: {
				startTime: config.startTime.toISOString(),
				endTime: config.endTime.toISOString()
			}
		});
	} catch (error) {
		console.error('Error updating game config:', error);
		return json({ error: 'Erro ao atualizar configuração' }, { status: 500 });
	}
});

export const DELETE: RequestHandler = withAdminApiPermission(async () => {
	try {
		// Delete game config
		await prisma.gameConfig.deleteMany({});

		return json({ success: true, message: 'Configuração removida' });
	} catch (error) {
		console.error('Error deleting game config:', error);
		return json({ error: 'Erro ao remover configuração' }, { status: 500 });
	}
});
