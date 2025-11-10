import { PrismaClient } from '@prisma/client';
import { PrismaClient as PrismaClientEdge } from '@prisma/client/edge';
import { withAccelerate } from '@prisma/extension-accelerate';

const isProduction = process.env.NODE_ENV === 'production';

const prisma = isProduction
	? new PrismaClientEdge().$extends(withAccelerate())
	: new PrismaClient();

export default prisma;
