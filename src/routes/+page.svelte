<script lang="ts">
	import { onMount } from 'svelte';
	import ARScene from '$lib/components/ARScene.svelte';
	import GameUI from '$lib/components/GameUI.svelte';
	import TreasureManager from '$lib/components/TreasureManager.svelte';
	import { gameState } from '$lib/stores/gameState.svelte';
	
	let hasPermissions = $state(false);
	let permissionsDenied = $state(false);
	let isLoading = $state(false);
	let showIntro = $state(true);
	let debugInfo = $state('');

	onMount(() => {
		// Check if the browser supports required features
		// iOS Safari requires HTTPS for these APIs
		const isSecureContext = window.isSecureContext || location.protocol === 'https:';
		const hasGeolocation = 'geolocation' in navigator;
		const hasMediaDevices = 'mediaDevices' in navigator && typeof navigator.mediaDevices?.getUserMedia === 'function';
		
		// Create debug info
		debugInfo = `Debug: Protocol: ${location.protocol}, Secure: ${isSecureContext}, Geolocation: ${hasGeolocation}, MediaDevices: ${hasMediaDevices}, UserAgent: ${navigator.userAgent.includes('iPhone') ? 'iPhone' : 'Other'}`;
		
		if (!hasGeolocation || !hasMediaDevices) {
			console.error('Missing features:', { hasGeolocation, hasMediaDevices, isSecureContext });
			permissionsDenied = true;
		} else if (!isSecureContext && location.hostname !== 'localhost') {
			console.error('HTTPS required for camera/location access');
			permissionsDenied = true;
		}
	});

	async function startGame() {
		isLoading = true;
		try {
			// Request camera and location permissions
			await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } });
			await new Promise((resolve, reject) => {
				navigator.geolocation.getCurrentPosition(resolve, reject);
			});
			
			hasPermissions = true;
			showIntro = false;
			gameState.startGame();
		} catch (error) {
			alert('Please grant camera and location permissions to play the game.');
			console.error('Permission error:', error);
			permissionsDenied = true;
		} finally {
			isLoading = false;
		}
	}
</script>

<svelte:head>
	<title>AR Treasure Hunt</title>
	<meta name="description" content="Find hidden treasures in the real world using AR" />
</svelte:head>

<div class="app-container">
	{#if showIntro}
		<div class="intro-screen">
			<div class="intro-content">
				<h1>🏴‍☠️ AR Treasure Hunt</h1>
				<p class="subtitle">Explore the real world to find hidden treasures!</p>
				
				<div class="features">
					<div class="feature">
						<span class="icon">📍</span>
						<span>Location-based AR</span>
					</div>
					<div class="feature">
						<span class="icon">📷</span>
						<span>Uses your camera</span>
					</div>
					<div class="feature">
						<span class="icon">💎</span>
						<span>Collect treasures</span>
					</div>
				</div>

				{#if !permissionsDenied}
					<button class="start-button" onclick={startGame}>
						Start Adventure
					</button>
				{:else}
					<p class="warning">
						{#if location.protocol !== 'https:' && location.hostname !== 'localhost'}
							Please access this app via HTTPS for camera/location access.
						{:else}
							Your browser doesn't support the required features. Please use Safari or Chrome on iOS.
						{/if}
					</p>
					<p class="debug-info" style="font-size: 0.8em; color: #666; margin-top: 10px;">
						{debugInfo}
					</p>
				{/if}
			</div>
		</div>
	{:else if hasPermissions}
		<ARScene />
		<GameUI />
		<TreasureManager />
	{/if}
</div>

<style>
	:global(body) {
		margin: 0;
		padding: 0;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
		overflow: hidden;
	}

	.app-container {
		width: 100vw;
		height: 100vh;
		position: relative;
	}

	.intro-screen {
		width: 100%;
		height: 100%;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		display: flex;
		align-items: center;
		justify-content: center;
		animation: gradient 15s ease infinite;
		background-size: 400% 400%;
	}

	@keyframes gradient {
		0% { background-position: 0% 50%; }
		50% { background-position: 100% 50%; }
		100% { background-position: 0% 50%; }
	}

	.intro-content {
		text-align: center;
		color: white;
		padding: 2rem;
		max-width: 500px;
	}

	h1 {
		font-size: 3rem;
		margin-bottom: 1rem;
		text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
	}

	.subtitle {
		font-size: 1.2rem;
		margin-bottom: 3rem;
		opacity: 0.95;
	}

	.features {
		display: flex;
		justify-content: space-around;
		margin-bottom: 3rem;
		gap: 1rem;
	}

	.feature {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 0.5rem;
	}

	.icon {
		font-size: 2rem;
	}

	.start-button {
		background: white;
		color: #667eea;
		border: none;
		padding: 1rem 3rem;
		font-size: 1.2rem;
		font-weight: bold;
		border-radius: 50px;
		cursor: pointer;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(0,0,0,0.2);
	}

	.start-button:hover {
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(0,0,0,0.3);
	}

	.warning {
		background: rgba(255,255,255,0.2);
		padding: 1rem;
		border-radius: 10px;
	}
</style>
