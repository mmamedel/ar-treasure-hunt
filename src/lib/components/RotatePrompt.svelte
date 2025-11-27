<script lang="ts">
	import { onMount } from 'svelte';

	let isLandscape = $state(false);

	function checkOrientation() {
		isLandscape = window.matchMedia('(orientation: landscape)').matches;
	}

	onMount(() => {
		checkOrientation();

		// Listen for orientation changes
		const mediaQuery = window.matchMedia('(orientation: landscape)');
		const handler = () => checkOrientation();
		mediaQuery.addEventListener('change', handler);

		// Also listen for resize events
		window.addEventListener('resize', checkOrientation);

		return () => {
			mediaQuery.removeEventListener('change', handler);
			window.removeEventListener('resize', checkOrientation);
		};
	});
</script>

{#if isLandscape}
	<div class="rotate-overlay">
		<div class="rotate-content">
			<img src="/images/phone-flip.svg" alt="Gire o telefone" class="phone-icon" />
			<h2>Gire seu dispositivo</h2>
			<p>Para a melhor experiência, por favor use o modo retrato (vertical)</p>
		</div>
	</div>
{/if}

<style>
	.rotate-overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #b5905f;
		background-image: url('/images/design/background2.png');
		background-size: cover;
		background-position: center;
		background-attachment: fixed;
		z-index: 9999;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.rotate-overlay::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(64, 57, 47, 0.5);
		backdrop-filter: blur(3px);
	}

	.rotate-content {
		position: relative;
		z-index: 1;
		text-align: center;
		padding: 2rem;
		color: white;
		max-width: 500px;
	}

	.phone-icon {
		width: 120px;
		height: 120px;
		margin: 0 auto 1.5rem;
		filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
		animation: rotate 2s ease-in-out infinite;
	}

	@keyframes rotate {
		0%,
		100% {
			transform: rotate(0deg);
		}
		25% {
			transform: rotate(-15deg);
		}
		75% {
			transform: rotate(15deg);
		}
	}

	.rotate-content h2 {
		font-family: var(--font-primary);
		font-size: 2rem;
		margin: 0 0 1rem 0;
		color: var(--color-accent);
		text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
	}

	.rotate-content p {
		font-family: var(--font-secondary);
		font-size: 1.1rem;
		margin: 0;
		line-height: 1.6;
		color: rgba(255, 255, 255, 0.95);
		text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
	}

	@media (orientation: landscape) and (max-height: 500px) {
		.phone-icon {
			width: 80px;
			height: 80px;
			margin-bottom: 1rem;
		}

		.rotate-content h2 {
			font-size: 1.5rem;
			margin-bottom: 0.5rem;
		}

		.rotate-content p {
			font-size: 0.9rem;
		}

		.rotate-content {
			padding: 1rem;
		}
	}
</style>
