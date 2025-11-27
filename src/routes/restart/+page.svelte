<script lang="ts">
	import { onMount } from 'svelte';
	import { clearGameSession } from '$lib/stores/gameSessionPersisted';

	onMount(() => {
		// Clear the game session
		clearGameSession();

		// Force full page reload to home
		window.location.href = '/';
	});
</script>

<div class="restart-container">
	<p>Reiniciando jogo...</p>
</div>

<style>
	.restart-container {
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 100vh;
		font-family: var(--font-secondary);
		font-size: 1.2rem;
		color: var(--color-primary);
	}
</style>
