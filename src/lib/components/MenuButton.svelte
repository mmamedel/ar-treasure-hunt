<script lang="ts">
	import { clearGameSession } from '$lib/stores/gameSessionPersisted';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';

	let { hasGameSession = false }: { hasGameSession?: boolean } = $props();

	let isClearing = $state(false);
	let isOpen = $state(false);

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

	function handleCollection() {
		goto('/collection');
		toggleMenu();
	}

	function handleClickOutside(event: MouseEvent) {
		const target = event.target as HTMLElement;
		if (isOpen && !target.closest('.menu') && !target.closest('.hamburger')) {
			isOpen = false;
		}
	}

	onMount(() => {
		document.addEventListener('click', handleClickOutside);
		return () => {
			document.removeEventListener('click', handleClickOutside);
		};
	});
</script>

<!-- Floating hamburger button -->
<button class="hamburger" onclick={toggleMenu} title="Menu"> ☰ </button>

<!-- Dropdown menu -->
{#if isOpen}
	<div class="menu">
		{#if hasGameSession}
			<button onclick={handleCollection}> 📦 Coleção </button>
		{/if}

		<button onclick={handleLeaderboard}> 🏆 Ranking </button>

		<button onclick={handleClear} disabled={isClearing}> 🔄 Reiniciar </button>
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
		border: var(--border-width) solid var(--color-border);
		background: var(--color-accent);
		color: var(--color-primary);
		font-size: 1.8rem;
		cursor: pointer;
		box-shadow: 0 4px 12px rgba(208, 141, 61, 0.4);
		display: flex;
		align-items: center;
		justify-content: center;
		transition: all 0.3s ease;
		z-index: 1000;
	}

	.hamburger:hover {
		transform: scale(1.1);
		box-shadow: 0 6px 20px rgba(208, 141, 61, 0.6);
	}

	.menu {
		position: fixed;
		bottom: 6.2rem;
		right: 2rem;
		background: rgba(242, 242, 242, 0.98);
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		padding: 0.5rem;
		box-shadow: 0 8px 24px rgba(64, 57, 47, 0.2);
		width: 13rem;
		display: flex;
		flex-direction: column;
		gap: 0.3rem;
		animation: fadeIn 0.2s ease-out;
		z-index: 1000;
		backdrop-filter: blur(10px);
	}

	.menu button {
		background: transparent;
		border: none;
		border-radius: var(--radius-sm);
		padding: 0.75rem 1rem;
		text-align: left;
		width: 100%;
		font-family: var(--font-secondary);
		font-size: 16px;
		font-weight: 600;
		color: var(--color-primary);
		cursor: pointer;
		transition:
			background 0.15s,
			transform 0.1s;
	}

	.menu button:hover {
		background: var(--color-accent);
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
