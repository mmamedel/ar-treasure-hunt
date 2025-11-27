<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	import { fade } from 'svelte/transition';
	import DecorativeBorder from '$lib/components/DecorativeBorder.svelte';

	const gameState = getGameState();
	let selectedTreasureId = $state<number | null>(null);

	// Auto-select the last found treasure on mount
	onMount(() => {
		const foundTreasures = gameState.treasures.filter((t) => t.found);
		if (foundTreasures.length > 0) {
			// Select the last found treasure (highest id)
			selectedTreasureId = foundTreasures[foundTreasures.length - 1].id;
		}
	});

	function handleBack() {
		goto('/');
	}

	function selectTreasure(treasureId: number, found: boolean) {
		if (found) {
			selectedTreasureId = treasureId;
		}
	}

	function getTreasureClass(treasure: any): string {
		const baseClass = treasure.found ? 'treasure-card found' : 'treasure-card locked';
		const selectedClass = selectedTreasureId === treasure.id ? ' selected' : '';
		return baseClass + selectedClass;
	}
</script>

<svelte:head>
	<title>Coleção - Caça ao Tesouro</title>
</svelte:head>

<DecorativeBorder />

<div class="container">
	<div class="header">
		<button class="back-button" onclick={handleBack}>«</button>
		<h1>🧳 Minha Coleção</h1>
		<p class="subtitle">
			{gameState.treasures.filter((t) => t.found).length} de {gameState.treasures.length} Tesouros Encontrados
		</p>
	</div>

	<div class="collection-grid">
		{#each gameState.treasures as treasure (treasure.id)}
			<div
				class={getTreasureClass(treasure)}
				onclick={() => selectTreasure(treasure.id, treasure.found)}
				onkeydown={(e) => {
					if (e.key === 'Enter' || e.key === ' ') {
						e.preventDefault();
						selectTreasure(treasure.id, treasure.found);
					}
				}}
				role="button"
				tabindex={treasure.found ? 0 : -1}
			>
				<div class="treasure-content">
					{#if treasure.found}
						<div class="image-wrapper">
							{#if selectedTreasureId === treasure.id}
								<!-- Animated GIF - removed from DOM when not selected -->
								<img
									src="/gifs/treasure-{treasure.id}.gif"
									alt=""
									class="treasure-image gif"
									in:fade={{ duration: 0 }}
									out:fade={{ duration: 300 }}
								/>
							{:else}
								<!-- Static PNG - fades in after GIF fades out -->
								<img
									src="/gifs/treasure-{treasure.id}-static.png"
									alt=""
									class="treasure-image static"
									in:fade={{ duration: 300, delay: 300 }}
									out:fade={{ duration: 0 }}
								/>
							{/if}
						</div>
					{:else}
						<div class="question-mark">?</div>
					{/if}
				</div>
			</div>
		{/each}
	</div>
</div>

<style>
	:global(body) {
		overflow-x: hidden;
	}

	* {
		box-sizing: border-box;
	}

	.container {
		width: 100%;
		min-height: calc(100vh - 3rem);
		padding: 2rem;
		padding-top: 3.5rem;
		overflow-x: hidden;
		overscroll-behavior-y: contain;
	}

	.header {
		text-align: center;
		color: var(--color-primary);
		margin-bottom: 2rem;
		margin-top: 4rem;
	}

	.header h1 {
		margin: 0;
		font-size: 2.5rem;
		font-weight: 700;
		font-family: var(--font-primary);
	}

	.subtitle {
		margin: 0.5rem 0 0 0;
		font-size: 1rem;
		color: var(--color-secondary);
		font-family: var(--font-primary);
	}

	.back-button {
		position: fixed;
		top: 3rem;
		left: 1.5rem;
		width: 3.5rem;
		height: 3.5rem;
		border-radius: 50%;
		background: var(--color-accent);
		color: var(--color-primary);
		border: var(--border-width) solid var(--color-border);
		font-size: 28px;
		font-family: var(--font-primary);
		cursor: pointer;
		z-index: 100;
		display: flex;
		align-items: center;
		justify-content: center;
		box-shadow: 0 4px 12px rgba(208, 141, 61, 0.4);
		transition: all 0.3s ease;
	}

	.back-button:hover {
		transform: scale(1.1);
		box-shadow: 0 6px 20px rgba(208, 141, 61, 0.6);
	}

	.collection-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
		gap: 1.5rem;
		max-width: 1200px;
		margin: 0 auto;
	}

	.treasure-card {
		background: white;
		border-radius: 16px;
		overflow: hidden;
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
		outline: 4px solid transparent;
		outline-offset: 0px;
		transition:
			transform 0.3s ease,
			box-shadow 0.3s ease,
			outline-color 0.3s ease;
		cursor: pointer;
	}

	.treasure-card:hover {
		transform: translateY(-5px);
		box-shadow: 0 12px 32px rgba(0, 0, 0, 0.2);
	}

	.treasure-card.locked {
		opacity: 0.6;
		cursor: default;
	}

	.treasure-card.locked:hover {
		transform: none;
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
	}

	.treasure-card.selected {
		outline-color: #ffd700;
		box-shadow:
			0 0 20px rgba(255, 215, 0, 0.6),
			0 12px 32px rgba(0, 0, 0, 0.2);
		transform: translateY(-8px) scale(1.02);
		animation: selectedPulse 2s ease-in-out infinite;
	}

	.treasure-card.selected:hover {
		transform: translateY(-8px) scale(1.02);
	}

	@keyframes selectedPulse {
		0%,
		100% {
			box-shadow:
				0 0 20px rgba(255, 215, 0, 0.6),
				0 12px 32px rgba(0, 0, 0, 0.2);
		}
		50% {
			box-shadow:
				0 0 30px rgba(255, 215, 0, 0.8),
				0 12px 32px rgba(0, 0, 0, 0.2);
		}
	}

	.treasure-content {
		width: 100%;
		height: 250px;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
		position: relative;
		padding: 0;
	}

	.treasure-card.found .treasure-content {
		background: #1a1614;
	}

	.image-wrapper {
		position: relative;
		width: 100%;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.treasure-image {
		position: absolute;
		width: 100%;
		height: 100%;
		object-fit: cover;
		border-radius: 16px;
	}

	.question-mark {
		font-size: 6rem;
		color: #999;
		font-weight: 700;
	}

	@media (max-width: 768px) {
		.container {
			padding: 1rem;
		}

		.header h1 {
			font-size: 1.8rem;
		}

		.collection-grid {
			grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
			gap: 1rem;
		}

		.treasure-content {
			height: 180px;
		}

		.question-mark {
			font-size: 4rem;
		}
	}
</style>
