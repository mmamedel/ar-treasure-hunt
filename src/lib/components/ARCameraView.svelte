<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState } from '$lib/stores/gameState';
	
	// Type for AFRAME on window
	const win = window as any;
	
	let isCapturing = false;
	let arContainer: HTMLDivElement;
	let hasDetectedMarker = false;
	let cameraError = '';
	let isLoading = true;
	let markerVisible = false;
	
	$: currentTreasure = $gameState.treasures[$gameState.currentTreasureIndex];
	$: treasureNumber = $gameState.currentTreasureIndex + 1;
	
	function handleBack() {
		gameState.navigateToScreen('clue');
	}
	
	function handleCapture() {
		if (!markerVisible || isCapturing) return;
		
		isCapturing = true;
		
		// Capture animation and success
		setTimeout(() => {
			gameState.captureTreasure();
			isCapturing = false;
		}, 500);
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
			
			// Create AR scene
			createARScene();
			
			isLoading = false;
		} catch (error) {
			console.error('Error initializing AR:', error);
			cameraError = 'Erro ao acessar câmera. Por favor, permita o acesso à câmera.';
			isLoading = false;
		}
	});
	
	onDestroy(() => {
		cleanupARScene();
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
	
	function createARScene() {
		if (!arContainer) return;
		
		// Create A-Frame scene
		const scene = document.createElement('a-scene');
		scene.setAttribute('embedded', '');
		scene.setAttribute('arjs', 'sourceType: webcam; debugUIEnabled: false; detectionMode: mono_and_matrix; matrixCodeType: 3x3;');
		scene.setAttribute('vr-mode-ui', 'enabled: false');
		scene.setAttribute('renderer', 'antialias: true; alpha: true');
		scene.style.width = '100%';
		scene.style.height = '100%';
		scene.style.position = 'absolute';
		scene.style.top = '0';
		scene.style.left = '0';
		scene.style.zIndex = '1';
		
		// Add camera
		const camera = document.createElement('a-entity');
		camera.setAttribute('camera', '');
		scene.appendChild(camera);
		
		// Add marker with kanji pattern
		const marker = document.createElement('a-marker');
		marker.setAttribute('preset', 'kanji');
		marker.setAttribute('smooth', 'true');
		marker.setAttribute('smoothCount', '10');
		marker.setAttribute('smoothTolerance', '.01');
		marker.setAttribute('smoothThreshold', '5');
		
		// Add treasure model to marker - use primitive shapes that work better
		const treasureModel = document.createElement('a-box');
		treasureModel.setAttribute('position', '0 0 0');
		treasureModel.setAttribute('scale', '0.5 0.5 0.5');
		treasureModel.setAttribute('material', 'color: #FFD700; metalness: 0.7; roughness: 0.3');
		treasureModel.setAttribute('animation', 'property: rotation; to: 0 360 0; dur: 3000; loop: true; easing: linear');
		
		// Add treasure emoji text above the box
		const treasureText = document.createElement('a-text');
		treasureText.setAttribute('value', currentTreasure.emoji);
		treasureText.setAttribute('position', '0 1 0');
		treasureText.setAttribute('align', 'center');
		treasureText.setAttribute('color', '#FFFFFF');
		treasureText.setAttribute('width', '6');
		
		// Add a simple sphere for glow effect
		const glowSphere = document.createElement('a-sphere');
		glowSphere.setAttribute('position', '0 0 0');
		glowSphere.setAttribute('radius', '0.6');
		glowSphere.setAttribute('material', 'color: #FFD700; opacity: 0.3; shader: flat');
		glowSphere.setAttribute('animation', 'property: scale; to: 1.2 1.2 1.2; dur: 1000; loop: true; dir: alternate; easing: easeInOutQuad');
		
		// Add all elements to marker
		marker.appendChild(glowSphere);
		marker.appendChild(treasureModel);
		marker.appendChild(treasureText);
		
		// Use a debounced approach for marker detection to prevent flickering
		let markerTimeout: NodeJS.Timeout;
		
		marker.addEventListener('markerFound', () => {
			console.log('Marker detected!');
			clearTimeout(markerTimeout);
			markerVisible = true;
			hasDetectedMarker = true;
		});
		
		marker.addEventListener('markerLost', () => {
			console.log('Marker lost!');
			// Add delay before hiding to prevent flickering
			clearTimeout(markerTimeout);
			markerTimeout = setTimeout(() => {
				markerVisible = false;
			}, 500);
		});
		
		scene.appendChild(marker);
		arContainer.appendChild(scene);
	}
	
	function cleanupARScene() {
		if (arContainer) {
			// Remove all A-Frame elements
			const scene = arContainer.querySelector('a-scene');
			if (scene) {
				scene.remove();
			}
		}
		
		// Stop any active media streams
		if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
			navigator.mediaDevices.getUserMedia({ video: true })
				.then(stream => {
					stream.getTracks().forEach(track => track.stop());
				})
				.catch(() => {});
		}
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
		<!-- AR.js scene will be inserted here -->
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
