/// <reference lib="webworker" />
declare const self: ServiceWorkerGlobalScope;

const CACHE_NAME = 'ar-treasure-hunt-v1';
const RUNTIME_CACHE = 'ar-treasure-hunt-runtime';

// Assets to cache on install
const PRECACHE_ASSETS = [
	'/',
	'/index.html',
	'/favicon.png',
	'/manifest.json',
	'/pattern-marker.patt',
	'/data/hiro.patt',
	'/data/kanji.patt',
	'/data/02.patt'
];

// Install event - precache essential assets
self.addEventListener('install', (event: ExtendableEvent) => {
	event.waitUntil(
		caches.open(CACHE_NAME).then((cache) => {
			return cache.addAll(PRECACHE_ASSETS).catch(() => {
				// Continue even if some assets fail to cache
				return Promise.resolve();
			});
		})
	);
	self.skipWaiting();
});

// Activate event - clean up old caches
self.addEventListener('activate', (event: ExtendableEvent) => {
	event.waitUntil(
		caches.keys().then((cacheNames) => {
			return Promise.all(
				cacheNames.map((cacheName) => {
					if (cacheName !== CACHE_NAME && cacheName !== RUNTIME_CACHE) {
						return caches.delete(cacheName);
					}
					return Promise.resolve();
				})
			);
		})
	);
	self.clients.claim();
});

// Fetch event - network first, fallback to cache, offline support
self.addEventListener('fetch', (event: FetchEvent) => {
	const { request } = event;
	const url = new URL(request.url);

	// Skip cross-origin requests
	if (url.origin !== location.origin) {
		return;
	}

	// Skip API calls for offline-first - they'll be handled by client
	if (url.pathname.startsWith('/api/')) {
		event.respondWith(
			fetch(request)
				.then((response) => {
					// Cache successful API responses
					if (response.ok) {
						const cacheCopy = response.clone();
						caches.open(RUNTIME_CACHE).then((cache) => {
							cache.put(request, cacheCopy);
						});
					}
					return response;
				})
				.catch(() => {
					// Return cached response if available
					return caches.match(request).then((cached) => {
						return (
							cached ||
							new Response(
								JSON.stringify({ error: 'offline', cached: false }),
								{
									status: 503,
									statusText: 'Service Unavailable',
									headers: { 'Content-Type': 'application/json' }
								}
							)
						);
					});
				})
		);
		return;
	}

	// For HTML, CSS, JS - network first
	if (
		request.method === 'GET' &&
		(url.pathname.endsWith('.html') ||
			url.pathname.endsWith('.js') ||
			url.pathname.endsWith('.css') ||
			url.pathname.endsWith('.json') ||
			url.pathname.endsWith('.png') ||
			url.pathname.endsWith('.jpg') ||
			url.pathname.endsWith('.jpeg') ||
			url.pathname.endsWith('.gif') ||
			url.pathname.endsWith('.svg') ||
			url.pathname.endsWith('.woff') ||
			url.pathname.endsWith('.woff2') ||
			url.pathname.endsWith('.ttf') ||
			url.pathname.endsWith('.patt'))
	) {
		event.respondWith(
			fetch(request)
				.then((response) => {
					if (response.ok) {
						const cacheCopy = response.clone();
						caches.open(RUNTIME_CACHE).then((cache) => {
							cache.put(request, cacheCopy);
						});
					}
					return response;
				})
				.catch(() => {
					return caches.match(request).then((cached) => {
						return (
							cached ||
							new Response('Offline - resource not available', {
								status: 503,
								statusText: 'Service Unavailable'
							})
						);
					});
				})
		);
		return;
	}

	// For other requests, use cache first
	event.respondWith(
		caches.match(request).then((cached) => {
			return (
				cached ||
				fetch(request).then((response) => {
					if (response.ok) {
						const cacheCopy = response.clone();
						caches.open(RUNTIME_CACHE).then((cache) => {
							cache.put(request, cacheCopy);
						});
					}
					return response;
				})
			);
		})
	);
});

// Background sync for queued actions when connection returns
self.addEventListener('sync', ((event: Event) => {
	const syncEvent = event as ExtendableEvent & { tag: string };
	if (syncEvent.tag === 'sync-game-data') {
		syncEvent.waitUntil(
			Promise.resolve().then(() => {
				// Notify all clients that sync is happening
				return self.clients.matchAll().then((clients) => {
					clients.forEach((client) => {
						client.postMessage({
							type: 'SYNC_START',
							tag: syncEvent.tag
						});
					});
				});
			})
		);
	}
}) as EventListener);

// Message handling for client communication
self.addEventListener('message', (event: ExtendableMessageEvent) => {
	if (event.data && event.data.type === 'SKIP_WAITING') {
		self.skipWaiting();
	}
});

export {};
