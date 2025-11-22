<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { goto } from '$app/navigation';

	const gameState = getGameState();

	function handleBack() {
		goto('/');
	}

	function getTreasureImage(treasure: any): string {
		// Return GIF path if found, otherwise show question mark
		if (treasure.found) {
			return `/gifs/treasure-${treasure.id}.gif`;
		}
		return '';
	}

	function getTreasureClass(found: boolean): string {
		return found ? 'treasure-card found' : 'treasure-card locked';
	}
</script>

<svelte:head>
	<title>Coleção - Caça ao Tesouro</title>
</svelte:head>

<div class="container">
	<div class="header">
		<button class="back-button" onclick={handleBack}>«</button>
		<h1>📦 Minha Coleção</h1>
		<p class="subtitle">
			{gameState.treasures.filter((t) => t.found).length} de {gameState.treasures.length} Tesouros Encontrados
		</p>
	</div>

	<div class="collection-grid">
		{#each gameState.treasures as treasure (treasure.id)}
			<div class={getTreasureClass(treasure.found)}>
				<div class="treasure-content">
					{#if treasure.found}
						<img
							src={getTreasureImage(treasure)}
							alt={treasure.name}
							class="treasure-image"
							onerror={(e) => {
								const target = e.currentTarget as HTMLImageElement;
								target.style.display = 'none';
								const fallback = target.nextElementSibling as HTMLElement;
								if (fallback) fallback.style.display = 'flex';
							}}
						/>
						<div class="fallback-emoji" style="display: none;">
							{treasure.emoji}
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
		min-height: 100vh;
		padding: 2rem;
		margin-top: 1.5rem;
		overflow-x: hidden;
	}

	.header {
		text-align: center;
		color: white;
		margin-bottom: 2rem;
	}

	.header h1 {
		margin: 0;
		font-size: 2.5rem;
		font-weight: 700;
	}

	.subtitle {
		margin: 0.5rem 0 0 0;
		font-size: 1rem;
		opacity: 0.9;
	}

	.back-button {
		position: fixed;
		top: 1rem;
		left: 1.5rem;
		background: rgba(255, 255, 255, 0.2);
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 20px;
		font-size: 16px;
		cursor: pointer;
		backdrop-filter: blur(10px);
		z-index: 100;
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
		transition:
			transform 0.3s ease,
			box-shadow 0.3s ease;
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

	.treasure-content {
		width: 100%;
		height: 200px;
		display: flex;
		align-items: center;
		justify-content: center;
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
		position: relative;
	}

	.treasure-card.found .treasure-content {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	}

	.treasure-image {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}

	.fallback-emoji {
		font-size: 5rem;
		display: flex;
		align-items: center;
		justify-content: center;
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
			height: 150px;
		}

		.question-mark {
			font-size: 4rem;
		}

		.fallback-emoji {
			font-size: 3.5rem;
		}
	}
</style>
