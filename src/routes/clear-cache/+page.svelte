<script>
	import { clearGameSession, getSession } from '$lib/stores/gameSessionPersisted';
	import { onMount } from 'svelte';

	function gameClear() {
		const session = getSession();
		if (!session.current?.playerName) {
			return;
		}

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
