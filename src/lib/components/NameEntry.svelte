<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { Debounced } from 'runed';
	import DecorativeBorder from './DecorativeBorder.svelte';
	import { onMount } from 'svelte';

	const gameState = getGameState();

	let playerName = $state('');
	let isValid = $state(false);
	let isChecking = $state(false);
	let validationMessage = $state('');
	let hasCheckedCurrentName = $state(false);
	let lastCheckedName = $state('');

	// Game config state
	let gameStatus = $state<'loading' | 'no_config' | 'before_start' | 'active' | 'ended'>('loading');
	let timeUntilStart = $state<number | null>(null);
	let countdown = $state({ days: 0, hours: 0, minutes: 0, seconds: 0 });
	let countdownInterval: ReturnType<typeof setInterval> | null = null;

	$effect(() => {
		playerName;
		hasCheckedCurrentName = false;
	});

	const debouncedName = new Debounced(() => playerName, 500);

	$effect(() => {
		const trimmed = debouncedName.current.trim();

		// Check if the name changed from what was last checked
		if (trimmed === lastCheckedName) {
			return;
		}

		// Basic length check
		if (trimmed.length === 0) {
			validationMessage = '';
			hasCheckedCurrentName = true;
			isValid = false;
			lastCheckedName = trimmed;
			return;
		}

		if (trimmed.length < 2) {
			validationMessage = 'Nome precisa ter mais de 2 letras';
			hasCheckedCurrentName = true;
			isValid = false;
			lastCheckedName = trimmed;
			return;
		}

		if (trimmed.length > 20) {
			validationMessage = 'Nome precisar ser de até 20 letras';
			hasCheckedCurrentName = true;
			isValid = false;
			lastCheckedName = trimmed;
			return;
		}

		// Only call API if we haven't checked this exact name yet
		if (trimmed !== lastCheckedName) {
			checkNameValidity(trimmed);
		}
	});

	async function checkNameValidity(name: string) {
		isChecking = true;
		validationMessage = 'Checking...';

		try {
			const response = await fetch('/api/game-session/check-name', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ playerName: name })
			});

			const data = await response.json();

			if (response.ok && data.available) {
				isValid = true;
				validationMessage = '';
			} else {
				isValid = false;
				validationMessage = data.reason || 'Nome invalido';
			}
		} catch (error) {
			console.error('Error checking name:', error);
			isValid = false;
			validationMessage = 'Um erro aconteceu validando o nome';
		} finally {
			hasCheckedCurrentName = true;
			lastCheckedName = name;
			isChecking = false;
		}
	}

	function handleSubmit() {
		if (isValid && hasCheckedCurrentName) {
			gameState.setPlayerName(playerName.trim());
			gameState.startGame(playerName);
		}
	}

	function handleKeyPress(event: KeyboardEvent) {
		if (event.key === 'Enter' && isValid && hasCheckedCurrentName) {
			handleSubmit();
		}
	}

	function updateCountdown(milliseconds: number) {
		const totalSeconds = Math.floor(milliseconds / 1000);
		const hours = Math.floor(totalSeconds / 3600);
		const minutes = Math.floor((totalSeconds % 3600) / 60);
		const seconds = totalSeconds % 60;

		countdown = { days: 0, hours, minutes, seconds };
	}

	async function checkGameConfig() {
		try {
			const response = await fetch('/api/game-config');
			const data = await response.json();

			if (!data.exists) {
				gameStatus = 'no_config';
				return;
			}

			gameStatus = data.status;

			if (data.status === 'before_start' && data.timeUntilStart) {
				timeUntilStart = data.timeUntilStart;
				updateCountdown(data.timeUntilStart);

				// Clear any existing interval
				if (countdownInterval) {
					clearInterval(countdownInterval);
				}

				// Update countdown every second
				countdownInterval = setInterval(() => {
					if (timeUntilStart && timeUntilStart > 0) {
						timeUntilStart -= 1000;
						updateCountdown(timeUntilStart);

						// When countdown reaches 0, check config again
						if (timeUntilStart <= 0) {
							checkGameConfig();
						}
					}
				}, 1000);
			}
		} catch (error) {
			console.error('Erro ao buscar configuração do jogo:', error);
			// If no config, allow game to proceed
			gameStatus = 'no_config';
		}
	}

	onMount(() => {
		checkGameConfig();

		return () => {
			if (countdownInterval) {
				clearInterval(countdownInterval);
			}
		};
	});
</script>

<DecorativeBorder />

<div class="container">
	<div class="logo">
		<img src="/images/design/map-scroll.png" alt="Treasure Map" />
	</div>

	<h1>CAÇA AO TESOURO</h1>

	{#if gameStatus === 'loading'}
		<p class="subtitle">Carregando...</p>
	{:else if gameStatus === 'before_start'}
		<div class="countdown-container">
			<p class="countdown-message">O jogo começará em:</p>
			<div class="countdown-display">
				<div class="countdown-item">
					<span class="countdown-number">{countdown.hours.toString().padStart(2, '0')}</span>
					<span class="countdown-label">horas</span>
				</div>
				<div class="countdown-separator">:</div>
				<div class="countdown-item">
					<span class="countdown-number">{countdown.minutes.toString().padStart(2, '0')}</span>
					<span class="countdown-label">minutos</span>
				</div>
				<div class="countdown-separator">:</div>
				<div class="countdown-item">
					<span class="countdown-number">{countdown.seconds.toString().padStart(2, '0')}</span>
					<span class="countdown-label">segundos</span>
				</div>
			</div>
		</div>
	{:else if gameStatus === 'ended'}
		<p class="subtitle game-ended">O jogo já terminou!</p>
		<div class="thank-you-message">
			<p>🏆</p>
			<p>Obrigado a todos que participaram!</p>
			<p class="thank-you-sub">Foi uma aventura incrível!</p>
		</div>
	{:else if gameStatus === 'active' || gameStatus === 'no_config'}
		<p class="subtitle">Digite seu nome para começar a aventura</p>

		<div class="input-group">
			<input
				type="text"
				placeholder="Seu nome"
				maxlength="20"
				bind:value={playerName}
				onkeypress={handleKeyPress}
			/>
			<p class="validation-message info-message">ⓘ Este nome aparecerá no placar</p>
			{#if validationMessage && !isValid && playerName.trim().length > 0}
				<p
					class="validation-message"
					class:error={!isValid && playerName.trim().length > 0}
					class:pending={isChecking}
				>
					ⓘ {validationMessage}
				</p>
			{/if}
		</div>

		<button class="button" disabled={!isValid || !hasCheckedCurrentName} onclick={handleSubmit}>
			COMEÇAR AVENTURA
		</button>
	{/if}
</div>

<style>
	.container {
		position: relative;
		width: 100%;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 20px;
		padding-top: 60px;
		box-sizing: border-box;
		overflow-x: hidden;
		overscroll-behavior-y: contain;
	}

	.logo {
		width: 130px;
		height: 130px;
		margin: 80px auto 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-shrink: 0;
	}

	.logo img {
		width: 100%;
		height: 100%;
		object-fit: contain;
	}

	h1 {
		font-family: var(--font-primary);
		font-size: 24px;
		color: var(--color-primary);
		margin-bottom: 6px;
		letter-spacing: 0.5px;
		text-transform: uppercase;
		width: 100%;
		max-width: 380px;
		text-align: center;
	}

	.subtitle {
		font-family: var(--font-primary);
		font-size: 14px;
		color: var(--color-primary);
		margin-bottom: 24px;
		width: 100%;
		max-width: 380px;
		text-align: center;
	}

	.input-group {
		display: flex;
		flex-direction: column;
		margin-bottom: 1rem;
		width: 100%;
		max-width: 380px;
	}

	input {
		width: 100%;
		padding: 18px 20px;
		font-family: var(--font-primary);
		font-size: 16px;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		background: transparent;
		color: var(--color-primary);
		text-align: left;
		box-sizing: border-box;
	}

	input::placeholder {
		color: var(--color-primary);
		opacity: 0.6;
	}

	input:focus {
		outline: none;
		border-color: var(--color-accent);
	}

	.validation-message {
		font-family: var(--font-primary);
		font-size: 14px;
		margin: 8px 0 0 0;
		color: var(--color-secondary);
		text-align: left;
		padding-left: 4px;
	}

	.validation-message.error {
		color: #d06243;
	}

	.validation-message.pending {
		color: var(--color-accent);
	}

	.validation-message.info-message {
		color: var(--color-secondary);
	}

	.button {
		width: 258px;
		padding: 15px 30px;
		font-family: var(--font-primary);
		font-size: 16px;
		font-weight: normal;
		background: var(--color-accent);
		color: var(--color-primary);
		border: none;
		border-radius: var(--radius-full);
		cursor: pointer;
		transition:
			transform 0.2s,
			opacity 0.2s;
		text-transform: uppercase;
		letter-spacing: 0.5px;
		margin: 0 auto;
	}

	.button:hover:not(:disabled) {
		transform: scale(1.02);
		opacity: 0.9;
	}

	.button:disabled {
		opacity: 0.5;
		cursor: not-allowed;
		transform: none;
	}

	/* Countdown styles */
	.countdown-container {
		width: 100%;
		max-width: 600px;
		margin: 2rem auto;
		text-align: center;
		padding: 0 1rem;
	}

	.countdown-message {
		font-family: var(--font-secondary);
		font-size: 1.3rem;
		color: var(--color-primary);
		margin-bottom: 2rem;
		font-weight: 500;
	}

	.countdown-display {
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 0.25rem;
		flex-wrap: nowrap;
	}

	.countdown-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 0.25rem;
		min-width: 60px;
	}

	.countdown-number {
		font-family: var(--font-primary);
		font-size: 3.5rem;
		font-weight: bold;
		color: var(--color-primary);
		line-height: 1;
	}

	.countdown-label {
		font-family: var(--font-secondary);
		font-size: 0.75rem;
		color: var(--color-primary);
		margin-top: 0.25rem;
		font-weight: 500;
	}

	.countdown-separator {
		font-family: var(--font-primary);
		font-size: 2.5rem;
		font-weight: bold;
		color: var(--color-primary);
		margin: 0 0.25rem;
		align-self: center;
		padding-bottom: 1.25rem;
	}

	/* Thank you message styles */
	.game-ended {
		font-size: 1.5rem;
		color: #d06243;
	}

	.thank-you-message {
		text-align: center;
		margin: 0.5rem auto 2rem;
		max-width: 400px;
	}

	.thank-you-message p {
		font-family: var(--font-secondary);
		font-size: 1.5rem;
		color: var(--color-primary);
		margin: 1rem 0;
	}

	.thank-you-message p:first-child {
		font-size: 4rem;
		margin-bottom: 1.5rem;
	}

	.thank-you-sub {
		font-size: 1.1rem !important;
		color: var(--color-secondary) !important;
	}

	@media (max-width: 768px) {
		.countdown-container {
			padding: 0 0.5rem;
		}

		.countdown-message {
			font-size: 1.1rem;
			margin-bottom: 1.5rem;
		}

		.countdown-display {
			gap: 0.15rem;
		}

		.countdown-item {
			min-width: 50px;
			padding: 0.15rem;
		}

		.countdown-number {
			font-size: 2.5rem;
		}

		.countdown-label {
			font-size: 0.65rem;
		}

		.countdown-separator {
			font-size: 2rem;
			margin: 0 0.15rem;
			padding-bottom: 0.75rem;
		}
	}
</style>
