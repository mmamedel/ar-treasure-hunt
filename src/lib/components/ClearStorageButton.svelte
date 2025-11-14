<script lang="ts">
	import { clearGameSession } from '$lib/stores/gameSessionPersisted';

	let isClearing = false;

	async function handleClear() {
		if (confirm('Are you sure you want to clear all game data from storage?')) {
			isClearing = true;
			try {
				clearGameSession();
				// Optionally reload the page
				window.location.reload();
			} catch (error) {
				console.error('Error clearing storage:', error);
				isClearing = false;
			}
		}
	}
</script>

<button
	on:click={handleClear}
	disabled={isClearing}
	title="Clear all game data from local storage"
	class="clear-button"
>
	<span class="icon">🗑️</span>
</button>

<style>
	.clear-button {
		position: fixed;
		bottom: 2rem;
		right: 2rem;
		width: 3.5rem;
		height: 3.5rem;
		border-radius: 50%;
		border: none;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		font-size: 1.5rem;
		cursor: pointer;
		box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.3s ease;
		z-index: 1000;
	}

	.clear-button:hover:not(:disabled) {
		transform: scale(1.1);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
	}

	.clear-button:active:not(:disabled) {
		transform: scale(0.95);
	}

	.clear-button:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.icon {
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
