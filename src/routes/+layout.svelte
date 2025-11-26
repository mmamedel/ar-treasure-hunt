<script lang="ts">
	import { loadSession } from '$lib/stores/gameSessionPersisted';
	import MenuButton from '$lib/components/MenuButton.svelte';

	let { children } = $props();
	loadSession();
</script>

<svelte:head>
	<title>Caça ao Tesouro</title>
	<meta name="description" content="Encontre tesouros escondidos no mundo real usando a câmera" />
</svelte:head>

<div class="app-container">
	{@render children()}
	<MenuButton />
</div>

<style>
	:global(:root) {
		/* Design System Colors */
		--color-bg: #f2f2f2; /* Parchment background */
		--color-primary: #40392f; /* Dark brown text */
		--color-accent: #d08d3d; /* Golden tan */
		--color-secondary: #656565; /* Gray text */
		--color-border: #40392f; /* Border color */
		--color-clue-bg: rgba(208, 98, 67, 0.4); /* Salmon/coral */
		--color-success-bg: rgba(94, 146, 138, 0); /* Success card */

		/* Typography */
		--font-primary: 'IM Fell English SC', serif;
		--font-secondary: 'Montserrat', sans-serif;

		/* Border Radius */
		--radius-sm: 12px;
		--radius-md: 20px;
		--radius-lg: 50px;
		--radius-full: 100px;

		/* Border Width */
		--border-width: 3px;
	}

	:global(html) {
		background: var(--color-bg);
		height: 100%;
	}

	:global(body) {
		margin: 0;
		padding: 0;
		font-family: var(--font-primary);
		min-height: 100vh;
		color: var(--color-primary);
		overscroll-behavior-y: contain;
		background-image: url('/images/design/background.png');
		background-size: cover;
		background-position: center;
		background-attachment: fixed;
	}

	.app-container {
		width: 100vw;
		min-height: 100vh;
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
