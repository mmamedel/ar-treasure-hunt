<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import CaptureSuccess from './CaptureSuccess.svelte';
	import DecorativeBorder from './DecorativeBorder.svelte';
	import ProgressBar from './ProgressBar.svelte';
	import TreasureIcon from './TreasureIcon.svelte';
	const gameState = getGameState();

	let currentTreasure = $derived(gameState.treasures[gameState.currentTreasureIndex]);
	let treasureNumber = $derived(gameState.currentTreasureIndex + 1);
	let totalTreasures = $derived(gameState.treasures.length);

	let showHint = $state(false);
	let hintAvailable = $state(false);
	let timeUntilHint = $state('');

	const HINT_DELAY_MS = 5 * 60 * 1000; // 5 minutes

	// Check hint availability and update countdown every second
	$effect(() => {
		const checkHintAvailability = () => {
			if (!currentTreasure.start) {
				hintAvailable = false;
				return;
			}

			const elapsed = Date.now() - currentTreasure.start;
			const remaining = HINT_DELAY_MS - elapsed;

			if (remaining <= 0) {
				hintAvailable = true;
				timeUntilHint = '';
			} else {
				hintAvailable = false;
				const minutes = Math.floor(remaining / 60000);
				const seconds = Math.floor((remaining % 60000) / 1000);
				timeUntilHint = `${minutes}:${seconds.toString().padStart(2, '0')}`;
			}
		};

		checkHintAvailability();
		const interval = setInterval(checkHintAvailability, 1000);

		return () => clearInterval(interval);
	});

	function handleOpenCamera() {
		window.location.href = '/ar-viewer.html';
	}

	function toggleHint() {
		showHint = !showHint;
	}
</script>

{#if currentTreasure.found}
	<CaptureSuccess />
{:else}
	<DecorativeBorder />

	<div class="screen-container">
		<div class="timer-badge">
			<svg width="20" height="20" viewBox="0 0 20 20" fill="none">
				<circle cx="10" cy="10" r="8" stroke="currentColor" stroke-width="2" fill="none" />
				<path d="M10 6V10L13 13" stroke="currentColor" stroke-width="2" stroke-linecap="round" />
			</svg>
			<span>{gameState.elapsedTimeCodeClock}</span>
		</div>

		<div class="container">
			<div class="clue-card">
				<div class="clue-header">
					<div class="clue-icon-box">
						<TreasureIcon treasureId={currentTreasure.id} />
					</div>
					<div class="clue-title">Pista {treasureNumber} de {totalTreasures}</div>
				</div>

				<div class="clue-text">
					{currentTreasure.clue}
				</div>

				{#if showHint}
					<div class="hint-section">
						<div class="hint-label">
							<img src="/images/emojis/lightbulb.svg" alt="" class="hint-icon" />
							Dica
						</div>
						<div class="hint-text">{currentTreasure.hint}</div>
					</div>
				{/if}
			</div>

			{#if hintAvailable}
				<button class="hint-button" onclick={toggleHint}>
					<img src="/images/emojis/lightbulb.svg" alt="" class="hint-icon" />
					{showHint ? 'Esconder Dica' : 'Ver Dica'}
				</button>
			{:else}
				<div class="hint-timer">
					Dica disponível em {timeUntilHint}
				</div>
			{/if}

			<button class="camera-button" onclick={handleOpenCamera}>
				<svg width="23" height="21" viewBox="0 0 23 21" fill="none">
					<rect
						x="2"
						y="4"
						width="19"
						height="15"
						rx="2"
						stroke="currentColor"
						stroke-width="2"
						fill="none"
					/>
					<circle cx="11.5" cy="11.5" r="3.5" stroke="currentColor" stroke-width="2" fill="none" />
					<path d="M7 4L9 1H14L16 4" stroke="currentColor" stroke-width="2" />
				</svg>
				<span>ABRIR CÂMERA</span>
			</button>

			<div class="instructions">
				<p>Encontre o local indicado pela pista,</p>
				<p>procure pelo marcador Kenji no local.</p>
			</div>

			<div class="treasure-count">
				<div class="count-number">{gameState.treasures.filter((t) => t.found).length}</div>
			</div>

			<ProgressBar
				current={gameState.treasures.filter((t) => t.found).length}
				total={totalTreasures}
			/>
		</div>
	</div>
{/if}

<style>
	.screen-container {
		position: relative;
		width: 100%;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		padding: 20px;
		padding-top: 60px;
		box-sizing: border-box;
		overflow-y: auto;
		overscroll-behavior-y: contain;
	}

	.timer-badge {
		display: flex;
		align-items: center;
		gap: 8px;
		background: var(--color-accent);
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		padding: 10px 20px;
		font-family: var(--font-secondary);
		font-size: 20px;
		font-weight: 600;
		color: var(--color-primary);
		margin: 1rem auto;
		width: fit-content;
	}

	.timer-badge svg {
		color: var(--color-primary);
	}

	.container {
		flex: 1;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: flex-start;
		max-width: 400px;
		margin: 0 auto;
		width: 100%;
		padding: 10px 10px 20px;
		box-sizing: border-box;
	}

	.clue-card {
		background: var(--color-clue-bg);
		color: black;
		padding: 30px 24px;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		width: 100%;
		max-width: 350px;
		margin-bottom: 20px;
		box-sizing: border-box;
	}

	.clue-header {
		display: flex;
		align-items: center;
		gap: 14px;
		margin-bottom: 24px;
	}

	.clue-icon-box {
		background: #d06243;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-sm);
		width: 54px;
		height: 54px;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-shrink: 0;
	}

	.clue-title {
		font-family: var(--font-primary);
		font-size: 32px;
		color: var(--color-primary);
		letter-spacing: 0.5px;
	}

	.clue-text {
		font-family: var(--font-secondary);
		font-size: 20px;
		line-height: 1.5;
		text-align: left;
		color: black;
	}

	.hint-section {
		margin-top: 20px;
		padding-top: 20px;
		border-top: 2px dashed var(--color-border);
		animation: fadeIn 0.3s ease;
	}

	.hint-label {
		background: var(--color-accent);
		color: var(--color-primary);
		display: inline-flex;
		align-items: center;
		gap: 8px;
		padding: 8px 18px;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		font-family: var(--font-primary);
		font-weight: normal;
		margin-bottom: 12px;
		font-size: 16px;
	}

	.hint-label .hint-icon {
		width: 20px;
		height: 20px;
		filter: brightness(0) saturate(100%) invert(18%) sepia(13%) saturate(959%) hue-rotate(349deg)
			brightness(95%) contrast(93%);
	}

	.hint-text {
		font-family: var(--font-secondary);
		font-size: 16px;
		line-height: 1.5;
		text-align: left;
		color: var(--color-primary);
	}

	@keyframes fadeIn {
		from {
			opacity: 0;
			transform: translateY(-10px);
		}
		to {
			opacity: 1;
			transform: translateY(0);
		}
	}

	.hint-button {
		background: var(--color-accent);
		color: var(--color-primary);
		border: none;
		border-radius: var(--radius-lg);
		padding: 10px 24px;
		font-family: var(--font-primary);
		font-size: 14px;
		font-weight: normal;
		cursor: pointer;
		transition:
			transform 0.2s,
			opacity 0.2s;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 8px;
		margin: 0 auto 15px;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.hint-button .hint-icon {
		width: 18px;
		height: 18px;
		filter: brightness(0) saturate(100%) invert(18%) sepia(13%) saturate(959%) hue-rotate(349deg)
			brightness(95%) contrast(93%);
	}

	.hint-button:hover {
		transform: scale(1.02);
		opacity: 0.9;
	}

	.hint-button:active {
		transform: scale(0.98);
	}

	.hint-timer {
		background: rgba(255, 255, 255, 0.3);
		color: var(--color-secondary);
		padding: 10px 20px;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		font-family: var(--font-primary);
		font-size: 14px;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 8px;
		margin: 0 auto 15px;
	}

	.camera-button {
		background: var(--color-accent);
		color: var(--color-primary);
		border: none;
		border-radius: var(--radius-full);
		padding: 15px 40px;
		font-family: var(--font-primary);
		font-size: 16px;
		font-weight: normal;
		cursor: pointer;
		transition:
			transform 0.2s,
			opacity 0.2s;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 12px;
		margin: 0 auto 20px;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.camera-button svg {
		color: var(--color-primary);
	}

	.camera-button:hover {
		transform: scale(1.02);
		opacity: 0.9;
	}

	.instructions {
		text-align: center;
		margin-bottom: 30px;
		font-family: var(--font-primary);
		font-size: 12px;
		color: var(--color-secondary);
		text-transform: uppercase;
	}

	.instructions p {
		margin: 2px 0;
		line-height: 1.4;
	}

	.treasure-count {
		margin-bottom: 10px;
		text-align: center;
	}

	.count-number {
		font-family: var(--font-secondary);
		font-size: 30px;
		font-weight: bold;
		color: var(--color-primary);
	}
</style>
