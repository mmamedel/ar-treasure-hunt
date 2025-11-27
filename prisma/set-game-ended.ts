import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
	// Set game to be ended
	const startTime = new Date(Date.now() - 2 * 24 * 60 * 60 * 1000); // Started 2 days ago
	const endTime = new Date(Date.now() - 1000); // Ended 1 second ago

	const config = await prisma.gameConfig.upsert({
		where: { id: 1 },
		update: {
			startTime,
			endTime
		},
		create: {
			id: 1,
			startTime,
			endTime
		}
	});

	console.log('✅ Game is now ENDED');
	console.log('Started:', config.startTime);
	console.log('Ended:', config.endTime);
}

main()
	.catch((e) => {
		console.error(e);
		process.exit(1);
	})
	.finally(async () => {
		await prisma.$disconnect();
	});
