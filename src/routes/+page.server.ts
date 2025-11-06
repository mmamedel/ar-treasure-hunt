import prisma from '$lib/prisma';

export async function load() {
	const users = await prisma.user.findMany();
	console.log(users);

	return {
		users
	};
}
