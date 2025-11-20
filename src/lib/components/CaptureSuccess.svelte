<script lang="ts">
	import { updateDBTreasure } from '$lib/db/client';
	import { getSession } from '$lib/stores/gameSessionPersisted';
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { onMount } from 'svelte';

	const gameState = getGameState();
	const session = getSession();

	let currentTreasure = $derived(gameState.treasures[gameState.currentTreasureIndex]);
	let treasureNumber = $derived(gameState.currentTreasureIndex + 1);
	let totalTreasures = $derived(gameState.treasures.length);
	let remainingTreasures = $derived(totalTreasures - treasureNumber);

	function handleContinue() {
		gameState.nextTreasure();
	}

	onMount(async () => {
		if (!session.current || session.current.sync) {
			return;
		}

		try {
			await updateDBTreasure(gameState.playerName, currentTreasure);
			session.current.sync = true;
		} catch (error) {
			console.error('Failed to update current treasure in db');
		}
	});
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
			<span class="stat-value">{gameState.elapsedTimeCodeClock}</span>
		</div>
		<div class="stat-item">
			<span class="stat-label">Tesouros Restantes</span>
			<span class="stat-value">{remainingTreasures}</span>
		</div>
	</div>

	<button class="continue-button" onclick={handleContinue}> Próxima Pista → </button>
	<p class="motivational">
		{#if remainingTreasures === 1}
			🎯 Apenas mais um tesouro para completar!
		{:else if remainingTreasures <= 3}
			🔥 Você está quase lá! Continue assim!
		{:else}
			💪 Excelente! Continue explorando!
		{/if}
	</p>

	<div class="progress-bar">
		<div class="progress-fill" style="width: {(treasureNumber / totalTreasures) * 100}%"></div>
	</div>
</div>

<style>
	.container {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		width: 100%;
		max-width: 500px;
		margin: 0 auto;
		padding: 20px;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		box-sizing: border-box;
		overflow-y: auto;
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
		background: #4caf50;
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
		font-size: clamp(24px, 6vw, 32px);
		margin-bottom: 20px;
		animation: fadeInUp 0.6s ease 0.2s both;
		width: 100%;
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
		padding: 20px;
		margin-bottom: 20px;
		animation: fadeInUp 0.6s ease 0.3s both;
		width: 100%;
		max-width: 350px;
		box-sizing: border-box;
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
		margin-bottom: 20px;
		animation: fadeInUp 0.6s ease 0.4s both;
		width: 100%;
		max-width: 350px;
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
		max-width: 350px;
		height: 8px;
		background: rgba(255, 255, 255, 0.2);
		border-radius: 4px;
		overflow: hidden;
		animation: fadeInUp 0.6s ease 0.7s both;
	}

	.progress-fill {
		height: 100%;
		background: linear-gradient(90deg, #4caf50, #8bc34a);
		transition: width 1s ease;
		box-shadow: 0 0 10px rgba(76, 175, 80, 0.5);
	}

	/* Mobile optimizations */
	@media (max-width: 480px) {
		.container {
			padding: 15px;
		}

		.success-animation {
			height: 100px;
			margin-bottom: 20px;
		}

		.checkmark {
			width: 80px;
			height: 80px;
			font-size: 40px;
		}

		.sparkles {
			font-size: 100px;
		}

		.treasure-emoji {
			font-size: 60px;
		}

		.treasure-name {
			font-size: 20px;
		}

		.treasure-card {
			padding: 15px;
		}

		.stat-value {
			font-size: 20px;
		}

		.continue-button {
			padding: 12px 30px;
			font-size: 16px;
		}

		.motivational {
			margin-bottom: 20px;
		}
	}

	/* Small height devices */
	@media (max-height: 600px) {
		.container {
			justify-content: flex-start;
			padding-top: 10px;
		}

		.success-animation {
			height: 80px;
			margin-bottom: 15px;
		}

		.checkmark {
			width: 60px;
			height: 60px;
			font-size: 30px;
		}

		h1 {
			margin-bottom: 15px;
		}

		.treasure-card {
			margin-bottom: 15px;
		}

		.stats {
			margin-bottom: 15px;
		}
	}
</style>
