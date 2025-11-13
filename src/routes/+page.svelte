<script lang="ts">
	import ClueScreen from '$lib/components/ClueScreen.svelte';
	import NameEntry from '$lib/components/NameEntry.svelte';
	import { getGameState } from '$lib/stores/gameState.svelte';

	const { data } = $props();

	const gameState = getGameState();

	console.log(data.gameSessions);
</script>

{#if gameState.isGameActive}
	<ClueScreen />
{:else}
	<NameEntry />
{/if}
