/**
 * Simple offline awareness utilities for PWA
 */

export function isOnline(): boolean {
	return typeof navigator !== 'undefined' && navigator.onLine;
}

export function onOnlineStatusChange(callback: (online: boolean) => void): () => void {
	if (typeof window === 'undefined') return () => {};

	const handleOnline = () => callback(true);
	const handleOffline = () => callback(false);

	window.addEventListener('online', handleOnline);
	window.addEventListener('offline', handleOffline);

	return () => {
		window.removeEventListener('online', handleOnline);
		window.removeEventListener('offline', handleOffline);
	};
}
