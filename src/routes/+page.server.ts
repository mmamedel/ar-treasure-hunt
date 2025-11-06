import prisma from '$lib/prisma';

export async function load() {
	const gameSessions = await prisma.gameSession.findMany({
		include: {
			questions: true
		}
	});
	console.log(gameSessions);

	return {
		gameSessions
	};
}
