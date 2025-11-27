import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const POST: RequestHandler = async ({ cookies }) => {
	// Delete the admin auth cookie
	cookies.delete('admin_auth', { path: '/' });

	return json({ success: true });
};
