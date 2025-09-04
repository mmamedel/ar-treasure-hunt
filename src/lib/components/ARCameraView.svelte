<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState } from '$lib/stores/gameState';
	
	let isCapturing = false;
	let arScene: HTMLElement;
	let hasDetectedMarker = false;
	
	$: currentTreasure = $gameState.treasures[$gameState.currentTreasureIndex];
	$: treasureNumber = $gameState.currentTreasureIndex + 1;
	
	function handleBack() {
		gameState.navigateToScreen('clue');
	}
	
	function handleCapture() {
		if (!hasDetectedMarker || isCapturing) return;
		
		isCapturing = true;
		
		// Simulate capture animation
		setTimeout(() => {
			gameState.captureTreasure();
			isCapturing = false;
		}, 1000);
	}
	
	// Initialize AR.js when component mounts
	onMount(() => {
		// Load AR.js and A-Frame scripts if not already loaded
		if (!window.AFRAME) {
			const aframeScript = document.createElement('script');
			aframeScript.src = 'https://aframe.io/releases/1.4.0/aframe.min.js';
			document.head.appendChild(aframeScript);
			
			aframeScript.onload = () => {
				const arScript = document.createElement('script');
				arScript.src = 'https://raw.githack.com/AR-js-org/AR.js/master/aframe/build/aframe-ar.js';
				document.head.appendChild(arScript);
				
				arScript.onload = () => {
					initializeAR();
				};
			};
		} else {
			initializeAR();
		}
	});
	
	function initializeAR() {
		// For demo purposes, we'll simulate marker detection
		// In production, this would use actual AR.js marker detection
		setTimeout(() => {
			hasDetectedMarker = true;
		}, 3000);
	}
	
	onDestroy(() => {
		// Cleanup AR resources
		if (arScene && arScene.querySelector('a-scene')) {
			const scene = arScene.querySelector('a-scene');
			scene?.parentNode?.removeChild(scene);
		}
	});
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
	
	<div class="camera-view" bind:this={arScene}>
		<!-- AR.js will be initialized here -->
		<div class="ar-placeholder">
			<div class="camera-feed">
				📷 Câmera AR
				{#if !hasDetectedMarker}
					<p class="scanning">Procurando marcador...</p>
				{/if}
			</div>
			
			{#if hasDetectedMarker}
				<div class="ar-object">
					<div class="treasure-3d">
						{currentTreasure.emoji}
					</div>
				</div>
			{/if}
		</div>
	</div>
	
	<div class="bottom-controls">
		{#if hasDetectedMarker}
			<div class="detection-alert">
				✨ Tesouro detectado!
			</div>
			
			<button 
				class="capture-button {isCapturing ? 'capturing' : ''}" 
				on:click={handleCapture}
				disabled={isCapturing}
			>
				<span class="capture-icon">📸</span>
				<span>{isCapturing ? 'Capturando...' : 'Capturar Tesouro'}</span>
			</button>
		{:else}
			<div class="hint-text">
				Aponte a câmera para o marcador AR
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
		background: #000;
		display: flex;
		flex-direction: column;
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
	
	.camera-view {
		flex: 1;
		position: relative;
		overflow: hidden;
	}
	
	.ar-placeholder {
		width: 100%;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
	}
	
	.camera-feed {
		color: rgba(255, 255, 255, 0.5);
		font-size: 24px;
		text-align: center;
	}
	
	.scanning {
		margin-top: 20px;
		font-size: 16px;
		animation: pulse 1.5s infinite;
	}
	
	@keyframes pulse {
		0%, 100% { opacity: 0.5; }
		50% { opacity: 1; }
	}
	
	.ar-object {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	
	.treasure-3d {
		font-size: 120px;
		animation: float 3s ease-in-out infinite;
		filter: drop-shadow(0 10px 30px rgba(103, 126, 234, 0.5));
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
	
	@keyframes capture {
		0%, 100% { transform: scale(1); }
		50% { transform: scale(0.95); }
	}
	
	.capture-icon {
		font-size: 24px;
	}
	
	.hint-text {
		color: white;
		font-size: 16px;
		text-align: center;
	}
	
	.ar-instructions {
		color: rgba(255, 255, 255, 0.7);
		font-size: 14px;
		text-align: center;
	}
</style>
