<script lang="ts">
	import { gameState } from '$lib/stores/gameState';
	
	$: currentTreasure = $gameState.treasures[$gameState.currentTreasureIndex];
	$: treasureNumber = $gameState.currentTreasureIndex + 1;
	$: totalTreasures = $gameState.treasures.length;
	$: remainingTreasures = totalTreasures - treasureNumber;
	
	function handleContinue() {
		gameState.nextTreasure();
	}
</script>

<div class="container">
	<div class="success-animation">
		<div class="checkmark">✓</div>
		<div class="sparkles">✨</div>
	</div>
	
	<h1>Tesouro Capturado!</h1>
	
	<div class="treasure-card">
		<div class="treasure-emoji">{currentTreasure.emoji}</div>
		<div class="treasure-name">{currentTreasure.name}</div>
		<div class="treasure-number">#{treasureNumber} de {totalTreasures}</div>
	</div>
	
	<div class="stats">
		<div class="stat-item">
			<span class="stat-label">Tempo Total</span>
			<span class="stat-value">{$gameState.totalTime}</span>
		</div>
		<div class="stat-item">
			<span class="stat-label">Tesouros Restantes</span>
			<span class="stat-value">{remainingTreasures}</span>
		</div>
	</div>
	
	{#if remainingTreasures > 0}
		<button class="continue-button" on:click={handleContinue}>
			Próxima Pista →
		</button>
		<p class="motivational">
			{#if remainingTreasures === 1}
				🎯 Apenas mais um tesouro para completar!
			{:else if remainingTreasures <= 3}
				🔥 Você está quase lá! Continue assim!
			{:else}
				💪 Excelente! Continue explorando!
			{/if}
		</p>
	{:else}
		<div class="completion-message">
			<h2>🎉 Parabéns!</h2>
			<p>Você encontrou todos os tesouros!</p>
			<button class="continue-button" on:click={handleContinue}>
				Ver Resultado Final
			</button>
		</div>
	{/if}
	
	<div class="progress-bar">
		<div 
			class="progress-fill" 
			style="width: {treasureNumber / totalTreasures * 100}%"
		></div>
	</div>
</div>

<style>
	.container {
		width: 100%;
		max-width: 500px;
		margin: 0 auto;
		padding: 20px;
		text-align: center;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		justify-content: center;
	}
	
	.success-animation {
		position: relative;
		margin-bottom: 30px;
		height: 120px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	
	.checkmark {
		width: 100px;
		height: 100px;
		background: #4CAF50;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 50px;
		color: white;
		animation: scaleIn 0.5s ease;
		box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3);
	}
	
	@keyframes scaleIn {
		from {
			transform: scale(0);
			opacity: 0;
		}
		to {
			transform: scale(1);
			opacity: 1;
		}
	}
	
	.sparkles {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		font-size: 120px;
		animation: sparkle 1s ease;
		pointer-events: none;
	}
	
	@keyframes sparkle {
		0% {
			transform: translate(-50%, -50%) scale(0) rotate(0deg);
			opacity: 0;
		}
		50% {
			opacity: 1;
		}
		100% {
			transform: translate(-50%, -50%) scale(1.5) rotate(180deg);
			opacity: 0;
		}
	}
	
	h1 {
		font-size: 32px;
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.2s both;
	}
	
	@keyframes fadeInUp {
		from {
			transform: translateY(20px);
			opacity: 0;
		}
		to {
			transform: translateY(0);
			opacity: 1;
		}
	}
	
	.treasure-card {
		background: rgba(255, 255, 255, 0.1);
		border: 2px solid rgba(255, 255, 255, 0.3);
		border-radius: 20px;
		padding: 30px;
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.3s both;
	}
	
	.treasure-emoji {
		font-size: 80px;
		margin-bottom: 15px;
	}
	
	.treasure-name {
		font-size: 24px;
		font-weight: 600;
		margin-bottom: 10px;
	}
	
	.treasure-number {
		font-size: 16px;
		opacity: 0.8;
		background: rgba(103, 126, 234, 0.3);
		display: inline-block;
		padding: 5px 15px;
		border-radius: 15px;
	}
	
	.stats {
		display: flex;
		justify-content: space-around;
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.4s both;
	}
	
	.stat-item {
		display: flex;
		flex-direction: column;
		gap: 5px;
	}
	
	.stat-label {
		font-size: 14px;
		opacity: 0.7;
	}
	
	.stat-value {
		font-size: 24px;
		font-weight: 600;
	}
	
	.continue-button {
		background: linear-gradient(135deg, #667eea, #764ba2);
		color: white;
		border: none;
		padding: 15px 40px;
		border-radius: 30px;
		font-size: 18px;
		font-weight: 600;
		cursor: pointer;
		margin-bottom: 20px;
		transition: transform 0.2s;
		animation: fadeInUp 0.6s ease 0.5s both;
	}
	
	.continue-button:hover {
		transform: scale(1.05);
		box-shadow: 0 5px 20px rgba(103, 126, 234, 0.4);
	}
	
	.motivational {
		font-size: 16px;
		opacity: 0.9;
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.6s both;
	}
	
	.progress-bar {
		width: 100%;
		height: 8px;
		background: rgba(255, 255, 255, 0.2);
		border-radius: 4px;
		overflow: hidden;
		animation: fadeInUp 0.6s ease 0.7s both;
	}
	
	.progress-fill {
		height: 100%;
		background: linear-gradient(90deg, #4CAF50, #8BC34A);
		transition: width 1s ease;
		box-shadow: 0 0 10px rgba(76, 175, 80, 0.5);
	}
	
	.completion-message {
		margin: 20px 0;
		animation: fadeInUp 0.6s ease 0.5s both;
	}
	
	.completion-message h2 {
		font-size: 28px;
		margin-bottom: 10px;
	}
	
	.completion-message p {
		font-size: 18px;
		margin-bottom: 20px;
		opacity: 0.9;
	}
</style>
