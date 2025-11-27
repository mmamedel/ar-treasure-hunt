import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { ADMIN_PASSWORD } from '$lib/config/admin';

export const POST: RequestHandler = async ({ request, cookies }) => {
	try {
		const { password } = await request.json();

		if (password === ADMIN_PASSWORD) {
			// Set auth cookie (expires in 24 hours)
			cookies.set('admin_auth', ADMIN_PASSWORD, {
				path: '/',
				httpOnly: true,
				sameSite: 'strict',
				secure: process.env.NODE_ENV === 'production',
				maxAge: 60 * 60 * 24 // 24 hours
			});

			return json({ success: true });
		} else {
			return json({ error: 'Senha incorreta' }, { status: 401 });
		}
	} catch (error) {
		console.error('Login error:', error);
		return json({ error: 'Erro ao processar login' }, { status: 500 });
	}
};
