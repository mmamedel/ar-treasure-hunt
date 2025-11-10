/* import prisma from '$lib/prisma';

export async function load() {
	console.log(process.env.DATABASE_URL);
	console.log(process.env.POSTGRES_DB);

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
 */
