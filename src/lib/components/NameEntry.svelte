<script lang="ts">
	import { gameState } from '$lib/stores/gameState';
	
	let playerName = '';
	let isValid = false;
	
	$: isValid = playerName.trim().length >= 2 && playerName.trim().length <= 20;
	
	function handleSubmit() {
		if (isValid) {
			gameState.setPlayerName(playerName.trim());
			gameState.startGame();
		}
	}
	
	function handleKeyPress(event: KeyboardEvent) {
		if (event.key === 'Enter' && isValid) {
			handleSubmit();
		}
	}
</script>

<div class="container">
	<div class="logo">🗺️</div>
	<h1>Caça ao Tesouro AR</h1>
	<p class="subtitle">Digite seu nome para começar a aventura</p>
	
	<div class="input-group">
		<input 
			type="text" 
			placeholder="Seu nome" 
			maxlength="20" 
			bind:value={playerName}
			on:keypress={handleKeyPress}
			autofocus
		/>
	</div>
	
	<button 
		class="button" 
		disabled={!isValid}
		on:click={handleSubmit}
	>
		Começar Aventura
	</button>
	
	<p class="info">
		💡 Este nome aparecerá no placar
	</p>
</div>

<style>
	.container {
		width: 100%;
		max-width: 400px;
		text-align: center;
		margin: 0 auto;
	}
	
	.logo {
		width: 120px;
		height: 120px;
		background: rgba(255, 255, 255, 0.2);
		border-radius: 50%;
		margin: 0 auto 30px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 48px;
	}
	
	h1 {
		font-size: 28px;
		margin-bottom: 10px;
	}
	
	.subtitle {
		font-size: 16px;
		opacity: 0.9;
		margin-bottom: 40px;
	}
	
	.input-group {
		margin-bottom: 30px;
	}
	
	input {
		width: 100%;
		padding: 15px 20px;
		font-size: 18px;
		border: none;
		border-radius: 10px;
		background: rgba(255, 255, 255, 0.95);
		color: #333;
		text-align: center;
	}
	
	input::placeholder {
		color: #999;
	}
	
	.button {
		width: 100%;
		padding: 15px 30px;
		font-size: 18px;
		font-weight: 600;
		background: #4CAF50;
		color: white;
		border: none;
		border-radius: 10px;
		cursor: pointer;
		transition: transform 0.2s;
	}
	
	.button:hover:not(:disabled) {
		transform: scale(1.05);
	}
	
	.button:disabled {
		background: #ccc;
		cursor: not-allowed;
		transform: none;
	}
	
	.info {
		margin-top: 30px;
		font-size: 14px;
		opacity: 0.8;
	}
</style>
