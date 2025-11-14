<script lang="ts">
	import { clearGameSession } from '$lib/stores/gameSessionPersisted';
	import { goto } from '$app/navigation';

	let isClearing = false;
	let isOpen = false;

	async function handleClear() {
		toggleMenu();
		if (confirm('Todo seu progresso vai ser perdido. Tem certeza que deseja continuar?')) {
			isClearing = true;
			try {
				clearGameSession();
				window.location.reload();
			} catch (error) {
				console.error('Error clearing storage:', error);
				isClearing = false;
			}
		}
	}

	function toggleMenu() {
		isOpen = !isOpen;
	}

	function handleLeaderboard() {
		goto('/leaderboard');
		toggleMenu();
	}
</script>

<!-- Floating hamburger button -->
<button class="hamburger" on:click={toggleMenu} title="Menu"> ☰ </button>

<!-- Dropdown menu -->
{#if isOpen}
	<div class="menu">
		<button on:click={handleClear} disabled={isClearing}> Reiniciar </button>

		<button on:click={handleLeaderboard}> Ranking </button>
	</div>
{/if}

<style>
	.hamburger {
		position: fixed;
		bottom: 2rem;
		right: 2rem;
		width: 3.5rem;
		height: 3.5rem;
		border-radius: 50%;
		border: none;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		font-size: 1.8rem;
		cursor: pointer;
		box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.3s ease;
		z-index: 1000;
	}

	.hamburger:hover {
		transform: scale(1.1);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
	}

	.menu {
		position: fixed;
		bottom: 6.2rem;
		right: 2rem;
		background: white;
		border-radius: 1rem;
		padding: 0.8rem 0;
		box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
		width: 12rem;
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		animation: fadeIn 0.2s ease-out;
		z-index: 1000;
	}

	.menu button {
		background: none;
		border: none;
		padding: 0.8rem 1rem;
		text-align: left;
		width: 100%;
		font-size: 1rem;
		cursor: pointer;
		transition:
			background 0.15s,
			transform 0.1s;
	}

	.menu button:hover {
		background: #f1f1f9;
	}

	.menu button:active {
		transform: scale(0.97);
	}

	@keyframes fadeIn {
		from {
			opacity: 0;
			transform: translateY(5px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}
</style>
