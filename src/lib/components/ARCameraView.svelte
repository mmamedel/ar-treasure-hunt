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
		// Check marker is visible AND not already capturing
		if (!markerVisible || isCapturing || !hasDetectedMarker) return;

		isCapturing = true;
		hasDetectedMarker = true;

		// Visual feedback
		console.log('Capturing treasure:', currentTreasure.name);

		// Change box color to green when capturing
		const treasureBox = document.getElementById('treasure-box');
		if (treasureBox) {
			treasureBox.setAttribute('material', 'color: #4CAF50');
		}

		// Simulate capture animation
		setTimeout(() => {
			gameState.captureTreasure();
			isCapturing = false;
			// Reset box color to gold
			if (treasureBox) {
				treasureBox.setAttribute('material', 'color: #FFD700');
			}
		}, 800);
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
	onMount(() => {
		// Store event handler for cleanup
		let handleSceneClick: ((e: Event) => void) | null = null;

		const initAR = async () => {
			try {
<<<<<<< HEAD
				// Request camera permissions with better quality settings
				await navigator.mediaDevices.getUserMedia({
					video: {
						facingMode: 'environment',
						width: { ideal: 1280 },
						height: { ideal: 720 }
					}
				});
=======
				// Request camera permissions
				await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } });
>>>>>>> parent of 80b3596 (feat: improve AR marker detection with enhanced camera settings and smoother tracking)

				// Load A-Frame and AR.js
				if (!(window as any).AFRAME) {
					await loadScript('https://aframe.io/releases/1.4.0/aframe.min.js');
				}
				await loadScript(
					'https://raw.githack.com/AR-js-org/AR.js/master/aframe/build/aframe-ar.js'
				);

				// Wait a bit for scripts to fully initialize
				await new Promise((resolve) => setTimeout(resolve, 500));

				scriptsLoaded = true;

				// Attach event listeners after scene is created
				setTimeout(() => {
					if (markerElement) {
						markerElement.addEventListener('markerFound', handleMarkerFound);
						markerElement.addEventListener('markerLost', handleMarkerLost);
					}

					// Add click event listener to treasure box
					const treasureBox = document.getElementById('treasure-box');
					if (treasureBox) {
						treasureBox.addEventListener('click', handleCapture);
						// Add touch events for mobile
						treasureBox.addEventListener('touchstart', handleCapture);
					}

					// Add touch/click listener to the entire scene for mobile AR fallback
					const scene = document.querySelector('a-scene');
					if (scene) {
						handleSceneClick = (e: Event) => {
							// Only capture if marker is visible
							if (markerVisible) {
								handleCapture();
							}
						};
						scene.addEventListener('click', handleSceneClick);
						scene.addEventListener('touchend', handleSceneClick);
					}
				}, 100);

				isLoading = false;
			} catch (error) {
				console.error('Error initializing AR:', error);
				cameraError = 'Erro ao acessar câmera. Por favor, permita o acesso à câmera.';
				isLoading = false;
			}
		};

		initAR();

		// Return cleanup function
		return () => {
			if (markerElement) {
				markerElement.removeEventListener('markerFound', handleMarkerFound);
				markerElement.removeEventListener('markerLost', handleMarkerLost);
			}
			const treasureBox = document.getElementById('treasure-box');
			if (treasureBox) {
				treasureBox.removeEventListener('click', handleCapture);
				treasureBox.removeEventListener('touchstart', handleCapture);
			}
			const scene = document.querySelector('a-scene');
			if (scene && handleSceneClick) {
				scene.removeEventListener('click', handleSceneClick);
				scene.removeEventListener('touchend', handleSceneClick);
			}
		};
	});

	onDestroy(() => {
		// Clear timeout
		clearTimeout(markerTimeout);

		// Stop any active media streams
		if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
			navigator.mediaDevices
				.getUserMedia({ video: true })
				.then((stream) => {
					stream.getTracks().forEach((track) => track.stop());
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
		<button class="back-button" on:click={handleBack}> ← Voltar </button>
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
<<<<<<< HEAD
				arjs="trackingMethod: best; sourceType: webcam; debugUIEnabled: true; detectionMode: mono_and_matrix; matrixCodeType: 3x3; smooth: true; smoothCount: 5; smoothTolerance: 0.01; smoothThreshold: 5; patternRatio: 0.75; maxDetectionRate: 60;"
=======
				arjs="trackingMethod: best; sourceType: webcam; debugUIEnabled: false;"
>>>>>>> parent of 80b3596 (feat: improve AR marker detection with enhanced camera settings and smoother tracking)
				vr-mode-ui="enabled: false"
				renderer="logarithmicDepthBuffer: true;"
			>
				<a-camera-static>
					<!-- Cursor for click detection only - no fuse/gaze triggering -->
					<a-cursor
						visible="false"
						fuse="false"
						fuseTimeout="0"
						raycaster="objects: .clickable; far: 100"
						geometry="radiusInner: 0; radiusOuter: 0"
					></a-cursor>
				</a-camera-static>

				<a-marker
					preset={currentTreasure.markerType}
					bind:this={markerElement}
					on:markerFound={handleMarkerFound}
					on:markerLost={handleMarkerLost}
<<<<<<< HEAD
					smooth="true"
					smoothCount="5"
					smoothTolerance="0.01"
					smoothThreshold="5"
=======
>>>>>>> parent of 80b3596 (feat: improve AR marker detection with enhanced camera settings and smoother tracking)
				>
					<!-- Clickable treasure model -->
					<a-box id="treasure-box" class="clickable" position="0 0.5 0" material="color: #FFD700"
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
		{#if isCapturing}
			<div class="capture-feedback">📸 Capturando tesouro...</div>
		{:else if markerVisible}
			<div class="detection-alert">✨ Clique no tesouro para capturá-lo!</div>
		{:else if hasDetectedMarker}
			<div class="hint-text">🔍 Procurando marcador...</div>
		{:else}
			<div class="hint-text">📷 Aponte para o marcador Kanji</div>
		{/if}

		<div class="ar-instructions">
			<p>
				💡 {markerVisible
					? 'Toque no tesouro dourado para capturá-lo'
					: 'Mantenha o marcador visível e centralizado'}
			</p>
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
		background: linear-gradient(to bottom, rgba(0, 0, 0, 0.8), transparent);
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
		0%,
		100% {
			opacity: 0.5;
		}
		50% {
			opacity: 1;
		}
	}

	@keyframes float {
		0%,
		100% {
			transform: translateY(0px);
		}
		50% {
			transform: translateY(-20px);
		}
	}

	.bottom-controls {
		position: absolute;
		bottom: 0;
		left: 0;
		right: 0;
		padding: 30px 20px;
		background: linear-gradient(to top, rgba(0, 0, 0, 0.8), transparent);
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

	.capture-feedback {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		padding: 15px 30px;
		border-radius: 25px;
		font-size: 18px;
		font-weight: 600;
		animation: pulse 1s infinite;
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
	}

	@keyframes pulse {
		0% {
			transform: scale(1);
			box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
		}
		50% {
			transform: scale(1.05);
			box-shadow: 0 4px 20px rgba(102, 126, 234, 0.6);
		}
		100% {
			transform: scale(1);
			box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
		}
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
