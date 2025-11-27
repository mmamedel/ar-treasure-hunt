import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
	// Set game to start 5 minutes from now and end in 2 hours
	const startTime = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes from now
	const endTime = new Date(Date.now() + 2 * 60 * 60 * 1000); // 2 hours from now

	// Upsert game config (update if exists, create if not)
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

	console.log('Game config created/updated:');
	console.log('Start time:', config.startTime);
	console.log('End time:', config.endTime);
}

main()
	.catch((e) => {
		console.error(e);
		process.exit(1);
	})
	.finally(async () => {
		await prisma.$disconnect();
	});
