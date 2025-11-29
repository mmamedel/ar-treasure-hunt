<script>
	import { clearGameSession } from '$lib/stores/gameSessionPersisted';
	import { onMount } from 'svelte';

	function gameClear() {
		if (confirm('Todo seu progresso vai ser perdido. Tem certeza que deseja continuar?')) {
			try {
				clearGameSession();
				window.location.reload();
			} catch (error) {
				console.error('Error clearing storage:', error);
			}
		}
	}

	onMount(gameClear);
</script>
