import type { PageServerLoad } from './$types';
import prisma from '$lib/prisma';
import { withAdminPermission } from '$lib/config/admin';

export const load: PageServerLoad = withAdminPermission(async () => {
	// Get current game config
	const config = await prisma.gameConfig.findFirst();

	return {
		config: config
			? {
					startTime: config.startTime.toISOString(),
					endTime: config.endTime.toISOString()
				}
			: null
	};
});
