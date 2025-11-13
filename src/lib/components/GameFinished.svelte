<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	const gameState = getGameState();
</script>

<div class="container">
	<div class="success-animation">
		<div class="checkmark">✓</div>
		<div class="sparkles">✨</div>
	</div>

	<h1>PARABÉNS!</h1>
	<h1>Você pegou todos os tesouros!</h1>

	<div class="stats">
		<div class="stat-item">
			<span class="stat-label">Tempo Total</span>
			<span class="stat-value">{gameState.duration}</span>
		</div>
	</div>

	<div class="completion-message"></div>
</div>

<style>
	.container {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		width: 100%;
		max-width: 500px;
		margin: 0 auto;
		padding: 20px;
		text-align: center;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		box-sizing: border-box;
		overflow-y: auto;
	}

	.success-animation {
		position: relative;
		margin-bottom: 30px;
		height: 120px;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.checkmark {
		width: 100px;
		height: 100px;
		background: #4caf50;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 50px;
		color: white;
		animation: scaleIn 0.5s ease;
		box-shadow: 0 10px 30px rgba(76, 175, 80, 0.3);
	}

	@keyframes scaleIn {
		from {
			transform: scale(0);
			opacity: 0;
		}
		to {
			transform: scale(1);
			opacity: 1;
		}
	}

	.sparkles {
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		font-size: 120px;
		animation: sparkle 1s ease;
		pointer-events: none;
	}

	@keyframes sparkle {
		0% {
			transform: translate(-50%, -50%) scale(0) rotate(0deg);
			opacity: 0;
		}
		50% {
			opacity: 1;
		}
		100% {
			transform: translate(-50%, -50%) scale(1.5) rotate(180deg);
			opacity: 0;
		}
	}

	h1 {
		font-size: clamp(24px, 6vw, 32px);
		margin-bottom: 20px;
		animation: fadeInUp 0.6s ease 0.2s both;
		width: 100%;
	}

	@keyframes fadeInUp {
		from {
			transform: translateY(20px);
			opacity: 0;
		}
		to {
			transform: translateY(0);
			opacity: 1;
		}
	}

	.stats {
		display: flex;
		justify-content: space-around;
		margin-bottom: 20px;
		animation: fadeInUp 0.6s ease 0.4s both;
		width: 100%;
		max-width: 350px;
	}

	.stat-item {
		display: flex;
		flex-direction: column;
		gap: 5px;
	}

	.stat-label {
		font-size: 14px;
		opacity: 0.7;
	}

	.stat-value {
		font-size: 24px;
		font-weight: 600;
	}

	.completion-message {
		margin: 20px 0;
		animation: fadeInUp 0.6s ease 0.5s both;
	}

	/* Mobile optimizations */
	@media (max-width: 480px) {
		.container {
			padding: 15px;
		}

		.success-animation {
			height: 100px;
			margin-bottom: 20px;
		}

		.checkmark {
			width: 80px;
			height: 80px;
			font-size: 40px;
		}

		.sparkles {
			font-size: 100px;
		}

		.stat-value {
			font-size: 20px;
		}
	}

	/* Small height devices */
	@media (max-height: 600px) {
		.container {
			justify-content: flex-start;
			padding-top: 10px;
		}

		.success-animation {
			height: 80px;
			margin-bottom: 15px;
		}

		.checkmark {
			width: 60px;
			height: 60px;
			font-size: 30px;
		}

		h1 {
			margin-bottom: 15px;
		}

		.stats {
			margin-bottom: 15px;
		}
	}
</style>
