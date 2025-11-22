<script lang="ts">
	import { loadSession } from '$lib/stores/gameSessionPersisted';
	import MenuButton from '$lib/components/MenuButton.svelte';

	let { children } = $props();
	loadSession();
</script>

<svelte:head>
	<title>Caça ao Tesouro AR</title>
	<meta name="description" content="Encontre tesouros escondidos no mundo real usando AR" />
</svelte:head>

<div class="app-container">
	{@render children()}
	<MenuButton />
</div>

<style>
	:global(html) {
		background: #6e64c6;
		height: 100%;
	}

	:global(body) {
		margin: 0;
		padding: 0;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
		min-height: 100vh;
		height: 100%;
		color: white;
		overscroll-behavior-y: contain;
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
