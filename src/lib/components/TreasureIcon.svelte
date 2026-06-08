<script lang="ts">
	interface Props {
		treasureId: number;
	}

	let { treasureId }: Props = $props();

	// Icon related to each clue's object
	const iconMap: Record<number, string> = {
		0: '🛝', // Balanço
		1: '🍖', // Churrasqueira
		2: '💡', // Poste de luz
		3: '🔥', // Fogão a lenha
		4: '🏡', // Varanda
		5: '🪴', // Vaso azul
		6: '🍋', // Pé de limão
		7: '🧊' // Freezer
	};

	const icon = $derived(iconMap[treasureId] || '❓');
</script>

<span class="treasure-icon" aria-hidden="true">{icon}</span>

<style>
	.treasure-icon {
		display: flex;
		align-items: center;
		justify-content: center;
		width: 100%;
		height: 100%;
		font-size: 30px;
		line-height: 1;
	}
</style>
