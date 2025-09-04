<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState } from '$lib/stores/gameState';
	
	// Type for AFRAME on window
	const win = window as any;
	
	let isCapturing = false;
	let markerElement: HTMLElement;
	let arContainer: HTMLDivElement;
	let hasDetectedMarker = false;
	let cameraError = '';
	let isLoading = true;
	let markerVisible = false;
	let scriptsLoaded = false;
	let markerTimeout: NodeJS.Timeout;
	
	$: currentTreasure = $gameState.treasures[$gameState.currentTreasureIndex];
	$: treasureNumber = $gameState.currentTreasureIndex + 1;
	
	function handleBack() {
		gameState.navigateToScreen('clue');
	}
	
	function handleCapture() {
		isCapturing = true;
		hasDetectedMarker = true;
		
		// Simulate capture animation
		setTimeout(() => {
			gameState.captureTreasure();
			isCapturing = false;
		}, 500);
	}
	
	function handleMarkerFound() {
		console.log('Marker detected!');
		clearTimeout(markerTimeout);
		markerVisible = true;
		hasDetectedMarker = true;
	}
	
	function handleMarkerLost() {
		console.log('Marker lost!');
		// Add delay before hiding to prevent flickering
		clearTimeout(markerTimeout);
		markerTimeout = setTimeout(() => {
			markerVisible = false;
		}, 300);
	}
	
	// Initialize AR.js when component mounts
	onMount(async () => {
		try {
			// Request camera permissions
			await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } });
			
			// Load AR.js and A-Frame scripts
			if (!win.AFRAME) {
				await loadScript('https://aframe.io/releases/1.4.0/aframe.min.js');
			}
			
			// Load AR.js
			await loadScript('https://raw.githack.com/AR-js-org/AR.js/master/aframe/build/aframe-ar.js');
			
			// Wait for libraries to initialize
			await new Promise(resolve => setTimeout(resolve, 500));
			
			scriptsLoaded = true;
			isLoading = false;
			
			// Wait a bit for A-Frame to initialize the marker element
			setTimeout(() => {
				if (markerElement) {
					markerElement.addEventListener('markerFound', handleMarkerFound);
					markerElement.addEventListener('markerLost', handleMarkerLost);
				}
			}, 100);
		} catch (error) {
			console.error('Error initializing AR:', error);
			cameraError = 'Erro ao acessar câmera. Por favor, permita o acesso à câmera.';
			isLoading = false;
		}
	});
	
	onDestroy(() => {
		// Clean up event listeners
		if (markerElement) {
			markerElement.removeEventListener('markerFound', handleMarkerFound);
			markerElement.removeEventListener('markerLost', handleMarkerLost);
		}
		
		// Clear timeout
		clearTimeout(markerTimeout);
		
		// Stop any active media streams
		if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
			navigator.mediaDevices.getUserMedia({ video: true })
				.then(stream => {
					stream.getTracks().forEach(track => track.stop());
				})
				.catch(() => {});
		}
	});
	
	function loadScript(src: string): Promise<void> {
		return new Promise((resolve, reject) => {
			const script = document.createElement('script');
			script.src = src;
			script.onload = () => resolve();
			script.onerror = reject;
			document.head.appendChild(script);
		});
	}
</script>

<div class="ar-container">
	<div class="header">
		<button class="back-button" on:click={handleBack}>
			← Voltar
		</button>
		<div class="treasure-info">
			Procurando: {currentTreasure.emoji} #{treasureNumber}
		</div>
	</div>
	
	<div class="ar-scene" bind:this={arContainer}>
		{#if isLoading}
			<div class="camera-placeholder">
				<div class="camera-icon">📷</div>
				<p>Carregando câmera AR...</p>
				<div class="scanning-animation"></div>
			</div>
		{:else if cameraError}
			<div class="camera-placeholder">
				<div class="camera-icon">⚠️</div>
				<p>{cameraError}</p>
			</div>
		{:else if scriptsLoaded}
			<!-- A-Frame AR Scene using Svelte template -->
			<a-scene
				embedded
				arjs="trackingMethod: best; sourceType: webcam; debugUIEnabled: false;"
				vr-mode-ui="enabled: false"
				renderer="logarithmicDepthBuffer: true;"
			>
				<a-camera-static></a-camera-static>
				
				<a-marker 
					preset="kanji"
					bind:this={markerElement}
					on:markerFound={handleMarkerFound}
					on:markerLost={handleMarkerLost}
				>
					<a-box
						position="0 0.5 0"
						material="color: yellow"
						animation="property: rotation; to: 360 360 0; dur: 3000; loop: true"
					></a-box>
					<a-text
						value={currentTreasure.emoji}
						position="0 1.5 0"
						align="center"
						color="#FFFFFF"
						width="4"
					></a-text>
				</a-marker>
			</a-scene>
		{/if}
	</div>
	
	<div class="bottom-controls">
		{#if hasDetectedMarker}
			<div class="detection-alert">
				✨ Tesouro detectado!
			</div>
			
			<button 
				class="capture-button"
				class:active={markerVisible}
				class:capturing={isCapturing}
				on:click={handleCapture}
				disabled={!markerVisible || isCapturing}
			>
				{#if isCapturing}
					<span class="capture-animation">📸</span>
					<span>Capturando...</span>
				{:else if markerVisible}
					<span>🎯</span>
					<span>Capturar Tesouro</span>
				{:else}
					<span>🔍</span>
					<span>Procurando Marcador...</span>
				{/if}
			</button>	
		{:else}
			<div class="hint-text">
				📷 Aponte para o marcador Kanji
			</div>
		{/if}
		
		<div class="ar-instructions">
			<p>💡 Mantenha o marcador visível e centralizado</p>
		</div>
	</div>
</div>

<style>
	.ar-container {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100vh;
		background: transparent;
		display: flex;
		flex-direction: column;
	}
	
	.ar-scene {
		position: relative;
		flex: 1;
		background: transparent;
		overflow: hidden;
	}
	
	.header {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		padding: 20px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		background: linear-gradient(to bottom, rgba(0,0,0,0.8), transparent);
		z-index: 10;
	}
	
	.back-button {
		background: rgba(255, 255, 255, 0.2);
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 20px;
		font-size: 16px;
		cursor: pointer;
		backdrop-filter: blur(10px);
	}
	
	.treasure-info {
		color: white;
		font-size: 16px;
		font-weight: 600;
		background: rgba(103, 126, 234, 0.8);
		padding: 10px 20px;
		border-radius: 20px;
	}
	
	
	@keyframes pulse {
		0%, 100% { opacity: 0.5; }
		50% { opacity: 1; }
	}
	
	@keyframes float {
		0%, 100% { transform: translateY(0px); }
		50% { transform: translateY(-20px); }
	}
	
	.bottom-controls {
		position: absolute;
		bottom: 0;
		left: 0;
		right: 0;
		padding: 30px 20px;
		background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
		z-index: 10;
	}
	
	.camera-placeholder {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		background: #1a1a1a;
		color: #fff;
		z-index: 1000;
	}
	
	.detection-alert {
		background: rgba(76, 175, 80, 0.9);
		color: white;
		padding: 10px 30px;
		border-radius: 20px;
		font-weight: 600;
		animation: slideUp 0.5s ease;
	}
	
	@keyframes slideUp {
		from {
			transform: translateY(20px);
			opacity: 0;
		}
		to {
			transform: translateY(0);
			opacity: 1;
		}
	}
	
	.capture-button {
		background: #FF5722;
		color: white;
		border: none;
		padding: 15px 40px;
		border-radius: 30px;
		font-size: 18px;
		font-weight: 600;
		cursor: pointer;
		display: flex;
		align-items: center;
		gap: 10px;
		transition: all 0.3s;
	}
	
	.capture-button:hover:not(:disabled) {
		transform: scale(1.05);
		box-shadow: 0 5px 20px rgba(255, 87, 34, 0.4);
	}
	
	.capture-button:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}
	
	.capture-button.capturing {
		animation: capture 1s ease;
	}
	
	.hint-text {
		background: rgba(0, 0, 0, 0.5);
		border-radius: 10px;
		margin-bottom: 1rem;
		color: white;
		text-align: center;
		padding: 1rem;
	}
	
	.ar-instructions {
		color: rgba(255, 255, 255, 0.7);
		font-size: 14px;
		text-align: center;
	}
</style>
