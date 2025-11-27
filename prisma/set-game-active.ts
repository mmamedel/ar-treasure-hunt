import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
	// Set game to be active now
	const startTime = new Date(Date.now() - 1000); // Started 1 second ago
	const endTime = new Date(Date.now() + 24 * 60 * 60 * 1000); // Ends in 24 hours

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

	console.log('✅ Game is now ACTIVE');
	console.log('Started:', config.startTime);
	console.log('Ends:', config.endTime);
}

main()
	.catch((e) => {
		console.error(e);
		process.exit(1);
	})
	.finally(async () => {
		await prisma.$disconnect();
	});
