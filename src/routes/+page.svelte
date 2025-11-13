<script lang="ts">
	import ClueScreen from '$lib/components/ClueScreen.svelte';
	import GameFinished from '$lib/components/GameFinished.svelte';
	import NameEntry from '$lib/components/NameEntry.svelte';
	import { getGameState } from '$lib/stores/gameState.svelte';

	const gameState = getGameState();
</script>

{#if gameState.isGameActive && !gameState.isFinished}
	<ClueScreen />
{:else if gameState.isFinished}
	<GameFinished />
{:else}
	<NameEntry />
{/if}
