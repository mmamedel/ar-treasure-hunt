<script lang="ts">
	import { createGameState } from '$lib/stores/gameState.svelte';
	import NameEntry from '$lib/components/NameEntry.svelte';
	import ClueScreen from '$lib/components/ClueScreen.svelte';
	import ARCameraView from '$lib/components/ARCameraView.svelte';
	import CaptureSuccess from '$lib/components/CaptureSuccess.svelte';

	const gameState = createGameState();
</script>

<svelte:head>
	<title>Caça ao Tesouro AR</title>
	<meta name="description" content="Encontre tesouros escondidos no mundo real usando AR" />
</svelte:head>

<div class="app-container">
	{#if gameState.currentScreen === 'name-entry'}
		<NameEntry />
	{:else if gameState.currentScreen === 'clue'}
		<ClueScreen />
	{:else if gameState.currentScreen === 'ar-camera'}
		<ARCameraView />
	{:else if gameState.currentScreen === 'capture-success'}
		<CaptureSuccess />
	{/if}
</div>

<style>
	:global(body) {
		margin: 0;
		padding: 0;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
		overflow: hidden;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		min-height: 100vh;
		color: white;
	}

	.app-container {
		width: 100vw;
		height: 100vh;
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
