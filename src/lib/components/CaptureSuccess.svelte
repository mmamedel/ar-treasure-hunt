<script lang="ts">
	import { updateDBTreasure } from '$lib/db/client';
	import { getSession } from '$lib/stores/gameSessionPersisted';
	import { getGameState } from '$lib/stores/gameState.svelte';
	import DecorativeBorder from './DecorativeBorder.svelte';
	import ProgressBar from './ProgressBar.svelte';
	import TreasureIcon from './TreasureIcon.svelte';
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

<DecorativeBorder />

<div class="container">
	<div class="treasure-chest">
		<img src="/images/design/treasure-chest.png" alt="Treasure Chest" />
	</div>

	<h1>TESOURO CAPTURADO!</h1>

	<div class="treasure-card">
		<div class="card-icon">
			<TreasureIcon treasureId={currentTreasure.id} />
		</div>
		<div class="card-title">{currentTreasure.name}</div>
		<div class="card-number">{treasureNumber} de {totalTreasures}</div>
	</div>

	<div class="time-section">
		<div class="time-label">Tempo total</div>
		<div class="time-value">{gameState.elapsedTimeCodeClock}</div>
	</div>

	{#if remainingTreasures === 0}
		<div class="completion-section">
			<h2>PARABÉNS</h2>
			<p>Você encontrou todos os tesouros!</p>
		</div>
		<ProgressBar current={totalTreasures} total={totalTreasures} />
	{:else}
		<button class="continue-button" onclick={handleContinue}> PRÓXIMA PISTA → </button>
		<p class="remaining-text">
			{#if remainingTreasures === 1}
				Apenas mais um tesouro!
			{:else}
				{remainingTreasures} tesouros restantes
			{/if}
		</p>
		<ProgressBar current={treasureNumber} total={totalTreasures} />
	{/if}
</div>

<style>
	.container {
		position: relative;
		width: 100%;
		max-width: 400px;
		min-height: 100vh;
		margin: 0 auto;
		padding: 20px;
		padding-top: 80px;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: flex-start;
		align-items: center;
		box-sizing: border-box;
		overflow-y: auto;
		overscroll-behavior-y: contain;
	}

	.treasure-chest {
		width: 143px;
		height: 143px;
		margin: 20px auto 30px;
		animation: scaleIn 0.5s ease;
	}

	.treasure-chest img {
		width: 100%;
		height: 100%;
		object-fit: contain;
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

	h1 {
		font-family: var(--font-primary);
		font-size: 24px;
		color: var(--color-primary);
		margin-bottom: 20px;
		text-transform: uppercase;
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
		background: var(--color-success-bg);
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		padding: 24px 32px;
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.3s both;
		width: 100%;
		max-width: 350px;
		box-sizing: border-box;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 12px;
	}

	.card-icon {
		background: var(--color-accent);
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-sm);
		width: 54px;
		height: 54px;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.card-title {
		font-family: var(--font-primary);
		font-size: 26px;
		color: var(--color-primary);
		text-align: center;
		line-height: 1.2;
	}

	.card-number {
		font-family: var(--font-primary);
		font-size: 34px;
		color: var(--color-accent);
	}

	.time-section {
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.4s both;
	}

	.time-label {
		font-family: var(--font-primary);
		font-size: 21px;
		color: var(--color-primary);
		margin-bottom: 4px;
	}

	.time-value {
		font-family: var(--font-secondary);
		font-size: 21px;
		font-weight: 600;
		color: var(--color-primary);
	}

	.completion-section {
		margin-bottom: 30px;
		animation: fadeInUp 0.6s ease 0.5s both;
	}

	.completion-section h2 {
		font-family: var(--font-primary);
		font-size: 24px;
		color: var(--color-primary);
		margin: 0 0 12px 0;
	}

	.completion-section p {
		font-family: var(--font-primary);
		font-size: 21px;
		color: black;
		margin: 0;
	}

	.continue-button {
		background: var(--color-accent);
		color: var(--color-primary);
		border: none;
		border-radius: var(--radius-full);
		padding: 15px 40px;
		font-family: var(--font-primary);
		font-size: 16px;
		font-weight: normal;
		cursor: pointer;
		margin-bottom: 20px;
		transition:
			transform 0.2s,
			opacity 0.2s;
		animation: fadeInUp 0.6s ease 0.5s both;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.continue-button:hover {
		transform: scale(1.02);
		opacity: 0.9;
	}

	.remaining-text {
		font-family: var(--font-primary);
		font-size: 16px;
		color: var(--color-primary);
		margin: 0 0 20px 0;
		animation: fadeInUp 0.6s ease 0.6s both;
	}
</style>
