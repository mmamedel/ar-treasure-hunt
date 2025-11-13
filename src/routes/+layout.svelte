<script lang="ts">
	import { loadSession } from '$lib/stores/gameSessionPersisted';

	let { children } = $props();
	loadSession();
</script>

<svelte:head>
	<title>Caça ao Tesouro AR</title>
	<meta name="description" content="Encontre tesouros escondidos no mundo real usando AR" />
</svelte:head>

<div class="app-container">
	{@render children()}
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
