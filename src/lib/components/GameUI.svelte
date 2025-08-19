<script lang="ts">
	import { gameState } from '../stores/gameState.svelte';
	import { fade, fly } from 'svelte/transition';
	
	let showMenu = $state(false);
	let showInventory = $state(false);
	
	function toggleMenu() {
		showMenu = !showMenu;
	}
	
	function toggleInventory() {
		showInventory = !showInventory;
	}
	
	function endGame() {
		if (confirm('Are you sure you want to end the game?')) {
			gameState.endGame();
			location.reload();
		}
	}
</script>

<div class="game-ui">
	<!-- Top Bar -->
	<div class="top-bar">
		<div class="stats-container">
			<div class="stat">
				<span class="icon">💎</span>
				<span class="value">{gameState.treasuresFound.length}/{gameState.totalTreasures}</span>
			</div>
			<div class="stat">
				<span class="icon">⭐</span>
				<span class="value">{gameState.score}</span>
			</div>
			<div class="stat">
				<span class="icon">🪙</span>
				<span class="value">{gameState.coins}</span>
			</div>
		</div>
		
		<button 
			class="menu-backdrop" 
			onclick={toggleMenu}
			aria-label="Close menu"
			type="button"
		>
			☰
		</button>
	</div>
	
	<!-- Progress Bar -->
	<div class="progress-container">
		<div class="progress-bar-fill" style="width: {gameState.progress}%"></div>
		<div class="progress-text">{Math.round(gameState.progress)}% Complete</div>
	</div>
	
	
	<!-- Bottom Controls -->
	<div class="bottom-controls">
		<button 
			class="menu-item" 
			onclick={() => { gameState.pauseGame(); toggleMenu(); }}
			type="button"
		>
			<span class="icon">⏸️</span>
			<span>Pause Game</span>
		</button>
		<button 
			class="menu-item" 
			onclick={() => { gameState.resumeGame(); toggleMenu(); }}
			type="button"
		>
			<span class="icon">▶️</span>
			<span>Resume Game</span>
		</button>
		<button class="control-button">
			<span class="icon">🗺️</span>
			<span>Map</span>
		</button>
	</div>
	
	<!-- Menu Modal -->
	{#if showMenu}
		<div 
			class="modal-overlay" 
			transition:fade 
			onclick={toggleMenu}
			onkeydown={(e) => e.key === 'Escape' && toggleMenu()}
			role="button"
			tabindex="0"
			aria-label="Close menu"
		>
			<div class="modal menu-modal" onclick={(e) => e.stopPropagation()}>
				<h2>Menu</h2>
				<button onclick={toggleMenu}>Settings</button>
				<button class="modal-button">Achievements</button>
				<button class="modal-button">Leaderboard</button>
				<button onclick={endGame}>End Game</button>
				<button class="modal-close" onclick={toggleMenu}>✕</button>
			</div>
		</div>
	{/if}
	
	<!-- Inventory Modal -->
	{#if showInventory}
		<div class="modal-overlay" transition:fade onclick={toggleInventory}>
			<div class="modal inventory-modal" transition:fly={{ y: 20 }} onclick={(e) => e.stopPropagation()}>
				<h2>Inventory</h2>
				<div class="inventory-grid">
					<span>{gameState.treasuresFound.length} treasures collected</span>
					{#each gameState.treasuresFound as treasureId}
						<div class="inventory-item">
							<span class="treasure-icon">💎</span>
							<span class="item-name">Treasure #{treasureId.slice(-4)}</span>
						</div>
					{/each}
				</div>
				<button onclick={toggleInventory}>Close</button>
			</div>
		</div>
	{/if}
</div>

<style>
	.game-ui {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		pointer-events: none;
		z-index: 10;
	}
	
	.top-bar {
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 1rem;
		background: linear-gradient(to bottom, rgba(0,0,0,0.5), transparent);
		pointer-events: all;
	}
	
	.stats-container {
		display: flex;
		gap: 1.5rem;
	}
	
	.stat {
		display: flex;
		align-items: center;
		gap: 0.5rem;
		background: rgba(255,255,255,0.2);
		padding: 0.5rem 1rem;
		border-radius: 20px;
		backdrop-filter: blur(10px);
	}
	
	.stat .icon {
		font-size: 1.2rem;
	}
	
	.stat .value {
		color: white;
		font-weight: bold;
		font-size: 1.1rem;
	}
	
	.menu-button {
		background: rgba(255,255,255,0.2);
		border: none;
		color: white;
		font-size: 1.5rem;
		width: 50px;
		height: 50px;
		border-radius: 50%;
		cursor: pointer;
		backdrop-filter: blur(10px);
		transition: all 0.3s ease;
	}
	
	.menu-button:hover {
		background: rgba(255,255,255,0.3);
		transform: scale(1.1);
	}
	
	.progress-container {
		position: absolute;
		top: 80px;
		left: 1rem;
		right: 1rem;
		height: 10px;
		background: rgba(255,255,255,0.2);
		border-radius: 5px;
		overflow: hidden;
		pointer-events: all;
	}
	
	.progress-bar {
		height: 100%;
		background: linear-gradient(90deg, #4CAF50, #8BC34A);
		transition: width 0.5s ease;
		border-radius: 5px;
	}
	
	.progress-text {
		position: absolute;
		top: -20px;
		right: 0;
		color: white;
		font-size: 0.8rem;
		text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
	}
	
	
	.bottom-controls {
		position: absolute;
		bottom: 20px;
		left: 50%;
		transform: translateX(-50%);
		display: flex;
		gap: 1rem;
		pointer-events: all;
	}
	
	.control-button {
		background: rgba(255,255,255,0.2);
		border: none;
		color: white;
		padding: 1rem;
		border-radius: 15px;
		cursor: pointer;
		backdrop-filter: blur(10px);
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 0.3rem;
		transition: all 0.3s ease;
		min-width: 80px;
	}
	
	.control-button:hover {
		background: rgba(255,255,255,0.3);
		transform: translateY(-2px);
	}
	
	.camera-button {
		background: rgba(76,175,80,0.3);
		border: 2px solid rgba(76,175,80,0.5);
	}
	
	.control-button .icon {
		font-size: 1.5rem;
	}
	
	.control-button span:last-child {
		font-size: 0.8rem;
	}
	
	.modal-overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0,0,0,0.7);
		display: flex;
		align-items: center;
		justify-content: center;
		pointer-events: all;
		z-index: 100;
	}
	
	.modal {
		background: white;
		padding: 2rem;
		border-radius: 20px;
		min-width: 300px;
		position: relative;
	}
	
	.modal h2 {
		margin-top: 0;
		color: #333;
	}
	
	.modal-button {
		display: block;
		width: 100%;
		padding: 1rem;
		margin: 0.5rem 0;
		background: #667eea;
		color: white;
		border: none;
		border-radius: 10px;
		cursor: pointer;
		font-size: 1rem;
		transition: all 0.3s ease;
	}
	
	.modal-button:hover {
		background: #5568d3;
		transform: translateX(5px);
	}
	
	.modal-close {
		position: absolute;
		top: 1rem;
		right: 1rem;
		background: none;
		border: none;
		font-size: 1.5rem;
		cursor: pointer;
		color: #666;
	}
	
	.inventory-modal {
		max-width: 500px;
		width: 90%;
	}
	
	.inventory-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
		gap: 1rem;
		margin-top: 1rem;
	}
	
	.inventory-item {
		background: #f5f5f5;
		padding: 1rem;
		border-radius: 10px;
		text-align: center;
		transition: all 0.3s ease;
	}
	
	.inventory-item:hover {
		transform: scale(1.05);
		background: #e8e8e8;
	}
	
	.treasure-icon {
		font-size: 2rem;
		display: block;
		margin-bottom: 0.5rem;
	}
	
	.item-name {
		font-size: 0.8rem;
		color: #666;
	}
</style>
