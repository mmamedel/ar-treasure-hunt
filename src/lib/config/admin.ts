import { redirect, type Cookies } from '@sveltejs/kit';

// TODO: Move to environment variable in production
export const ADMIN_PASSWORD = 'tesouro2025';

/**
 * Check if the user is authenticated as admin
 * @param cookies - SvelteKit cookies object
 * @returns true if authenticated, false otherwise
 */
export function isAdmin(cookies: Cookies): boolean {
	const authToken = cookies.get('admin_auth');
	return authToken === ADMIN_PASSWORD;
}

/**
 * Higher-order function that wraps a load function with admin authentication
 * Automatically redirects to /admin/login if not authenticated
 * @param fn - The load function to wrap
 * @returns Wrapped function that checks admin auth before executing
 */
export function withAdminPermission<T>(
	fn: (event: { cookies: Cookies; [key: string]: any }) => T | Promise<T>
) {
	return async (event: { cookies: Cookies; [key: string]: any }) => {
		if (!isAdmin(event.cookies)) {
			throw redirect(303, '/admin/login');
		}
		return await fn(event);
	};
}

/**
 * Higher-order function that wraps an API handler with admin authentication
 * Returns 401 JSON response if not authenticated
 * @param fn - The API handler function to wrap
 * @returns Wrapped function that checks admin auth before executing
 */
export function withAdminApiPermission(fn: (event: any) => Response | Promise<Response>) {
	return async (event: any) => {
		if (!isAdmin(event.cookies)) {
			return new Response(JSON.stringify({ error: 'Não autorizado' }), {
				status: 401,
				headers: { 'Content-Type': 'application/json' }
			});
		}
		return await fn(event);
	};
}
