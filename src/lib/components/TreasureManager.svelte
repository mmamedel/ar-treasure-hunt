<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState, type Treasure } from '../stores/gameState.svelte';
	import { fly, scale, fade } from 'svelte/transition';
	
	let showTreasureFound = $state(false);
	let foundTreasure = $state<Treasure | null>(null);
	let showGameComplete = $state(false);
	let checkInterval = $state<NodeJS.Timeout | null>(null);
	
	onMount(() => {
		// Check for nearby treasures periodically
		checkInterval = setInterval(checkForTreasures, 1000);
		
		return () => {
			if (checkInterval) {
				clearInterval(checkInterval);
			}
		};
	});
	
	function checkForTreasures() {
		if (!gameState.isPlaying || !gameState.playerLocation) return;
		
		// Check if player is near any treasure
		gameState.nearbyTreasures.forEach((treasure: Treasure) => {
			if (treasure.distance < 10 && !gameState.treasuresFound.includes(treasure.id)) {
				collectTreasure(treasure);
			}
		});
	}
	
	function collectTreasure(treasure: Treasure) {
		foundTreasure = treasure;
		showTreasureFound = true;
		gameState.collectTreasure(treasure.id);
		
		// Play collection sound effect (if available)
		playCollectionSound();
		
		// Hide notification after 3 seconds
		setTimeout(() => {
			showTreasureFound = false;
			foundTreasure = null;
		}, 3000);
		
		// Check if game is complete
		if (gameState.isComplete) {
			setTimeout(() => {
				showGameComplete = true;
			}, 3500);
		}
	}
	
	function playCollectionSound() {
		// Create a simple beep sound using Web Audio API
		const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
		const audioContext = new AudioContextClass();
		const oscillator = audioContext.createOscillator();
		const gainNode = audioContext.createGain();
		
		oscillator.connect(gainNode);
		gainNode.connect(audioContext.destination);
		
		oscillator.frequency.setValueAtTime(800, audioContext.currentTime);
		oscillator.frequency.exponentialRampToValueAtTime(400, audioContext.currentTime + 0.3);
		
		gainNode.gain.setValueAtTime(0.3, audioContext.currentTime);
		gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.3);
		
		oscillator.start(audioContext.currentTime);
		oscillator.stop(audioContext.currentTime + 0.3);
	}
	
	function restartGame() {
		showGameComplete = false;
		gameState.startGame();
	}
	
	function returnToMenu() {
		location.reload();
	}
	
	onDestroy(() => {
		if (checkInterval) {
			clearInterval(checkInterval);
		}
	});
</script>

<!-- Treasure Found Notification -->
{#if showTreasureFound && foundTreasure}
	<div class="treasure-notification" transition:scale>
		<div class="treasure-content">
			<span class="treasure-emoji">
				{#if foundTreasure.type === 'gem'}
					💎
				{:else if foundTreasure.type === 'coin'}
					🪙
				{:else}
					📦
				{/if}
			</span>
			<h3>Treasure Found!</h3>
			<p>+{foundTreasure.value} points</p>
		</div>
		<div class="sparkles">
			{#each Array(10) as _, i}
				<span 
					class="sparkle" 
					style="
						--delay: {i * 0.1}s;
						--x: {Math.random() * 100 - 50}px;
						--y: {Math.random() * 100 - 50}px;
					"
				>✨</span>
			{/each}
		</div>
	</div>
{/if}

<!-- AR Overlay for Treasures -->
<div class="ar-overlay">
	{#each gameState.nearbyTreasures as treasure}
		{#if treasure.distance < 100}
			<div 
				class="ar-treasure"
				style="
					opacity: {1 - (treasure.distance / 100)};
					transform: scale({1.5 - (treasure.distance / 100)});
				"
			>
				<div class="treasure-marker">
					{#if treasure.type === 'gem'}
						<div class="gem-3d">💎</div>
					{:else if treasure.type === 'coin'}
						<div class="coin-3d">🪙</div>
					{:else}
						<div class="chest-3d">📦</div>
					{/if}
					<div class="distance-label">{Math.round(treasure.distance)}m</div>
				</div>
			</div>
		{/if}
	{/each}
</div>

<!-- Game Complete Modal -->
{#if showGameComplete}
	<div class="game-complete-overlay" transition:fade>
		<div class="game-complete-modal" transition:fly={{ y: 50 }}>
			<h1>🎉 Victory! 🎉</h1>
			<div class="trophy">🏆</div>
			<div class="final-stats">
				<div class="stat-item">
					<span class="label">Final Score</span>
					<span class="value">{gameState.score}</span>
				</div>
				<div class="stat-item">
					<span class="label">Treasures Found</span>
					<span class="value">{gameState.treasuresFound.length}</span>
				</div>
				<div class="stat-item">
					<span class="label">Coins Earned</span>
					<span class="value">{gameState.coins}</span>
				</div>
			</div>
			<div class="complete-actions">
				<button class="action-button primary" onclick={restartGame}>
					Play Again
				</button>
				<button class="action-button secondary" onclick={returnToMenu}>
					Main Menu
				</button>
			</div>
		</div>
	</div>
{/if}

<style>
	.treasure-notification {
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		z-index: 1000;
		pointer-events: none;
	}
	
	.treasure-content {
		background: linear-gradient(135deg, #FFD700, #FFA500);
		padding: 2rem;
		border-radius: 20px;
		text-align: center;
		color: white;
		box-shadow: 0 10px 40px rgba(255, 215, 0, 0.5);
		animation: bounce 0.5s ease;
	}
	
	@keyframes bounce {
		0%, 100% { transform: scale(1); }
		50% { transform: scale(1.1); }
	}
	
	.treasure-emoji {
		font-size: 4rem;
		display: block;
		animation: spin 1s ease-in-out;
	}
	
	@keyframes spin {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
	}
	
	.treasure-content h3 {
		margin: 1rem 0 0.5rem;
		font-size: 1.5rem;
		text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
	}
	
	.treasure-content p {
		font-size: 1.2rem;
		font-weight: bold;
		margin: 0;
	}
	
	.sparkles {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		pointer-events: none;
	}
	
	.sparkle {
		position: absolute;
		font-size: 1.5rem;
		animation: sparkle-fly 1s ease-out forwards;
		animation-delay: var(--delay);
	}
	
	@keyframes sparkle-fly {
		0% {
			transform: translate(0, 0) scale(0);
			opacity: 1;
		}
		100% {
			transform: translate(var(--x), var(--y)) scale(1.5);
			opacity: 0;
		}
	}
	
	.ar-overlay {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		pointer-events: none;
		z-index: 5;
	}
	
	.ar-treasure {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		transition: all 0.3s ease;
	}
	
	.treasure-marker {
		text-align: center;
	}
	
	.gem-3d, .coin-3d, .chest-3d {
		font-size: 3rem;
		animation: float 3s ease-in-out infinite;
		filter: drop-shadow(0 5px 10px rgba(0,0,0,0.3));
	}
	
	@keyframes float {
		0%, 100% { transform: translateY(0); }
		50% { transform: translateY(-10px); }
	}
	
	.coin-3d {
		animation: float 3s ease-in-out infinite, rotate 5s linear infinite;
	}
	
	@keyframes rotate {
		0% { transform: rotateY(0deg); }
		100% { transform: rotateY(360deg); }
	}
	
	.distance-label {
		background: rgba(0,0,0,0.7);
		color: white;
		padding: 0.3rem 0.6rem;
		border-radius: 15px;
		font-size: 0.9rem;
		margin-top: 0.5rem;
		display: inline-block;
	}
	
	.game-complete-overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.9);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 2000;
	}
	
	.game-complete-modal {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		padding: 3rem;
		border-radius: 30px;
		text-align: center;
		color: white;
		max-width: 400px;
		width: 90%;
	}
	
	.game-complete-modal h1 {
		margin: 0 0 1rem;
		font-size: 2.5rem;
		text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
	}
	
	.trophy {
		font-size: 5rem;
		animation: trophy-bounce 1s ease infinite;
		margin: 1rem 0;
	}
	
	@keyframes trophy-bounce {
		0%, 100% { transform: scale(1) rotate(0deg); }
		25% { transform: scale(1.1) rotate(-5deg); }
		75% { transform: scale(1.1) rotate(5deg); }
	}
	
	.final-stats {
		background: rgba(255,255,255,0.1);
		padding: 1.5rem;
		border-radius: 20px;
		margin: 2rem 0;
	}
	
	.stat-item {
		display: flex;
		justify-content: space-between;
		margin: 0.8rem 0;
		font-size: 1.1rem;
	}
	
	.stat-item .label {
		opacity: 0.9;
	}
	
	.stat-item .value {
		font-weight: bold;
		font-size: 1.2rem;
	}
	
	.complete-actions {
		display: flex;
		gap: 1rem;
		justify-content: center;
		flex-wrap: wrap;
	}
	
	.action-button {
		padding: 1rem 2rem;
		border: none;
		border-radius: 25px;
		font-size: 1.1rem;
		font-weight: bold;
		cursor: pointer;
		transition: all 0.3s ease;
		min-width: 120px;
	}
	
	.action-button.primary {
		background: white;
		color: #667eea;
	}
	
	.action-button.secondary {
		background: rgba(255,255,255,0.2);
		color: white;
		backdrop-filter: blur(10px);
	}
	
	.action-button:hover {
		transform: translateY(-2px);
		box-shadow: 0 5px 20px rgba(0,0,0,0.3);
	}
</style>
