<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { Debounced } from 'runed';
	import DecorativeBorder from './DecorativeBorder.svelte';

	const gameState = getGameState();

	let playerName = $state('');
	let isValid = $state(false);
	let isChecking = $state(false);
	let validationMessage = $state('');
	let hasCheckedCurrentName = $state(false);
	let lastCheckedName = $state('');

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
</script>

<DecorativeBorder />

<div class="container">
	<div class="logo">
		<img src="/images/design/map-scroll.png" alt="Treasure Map" />
	</div>

	<h1>CAÇA AO TESOURO</h1>
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
</div>

<style>
	:global(body) {
		overflow: hidden !important;
	}

	.container {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		width: 100%;
		height: 100vh;
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 20px;
		padding-top: 60px;
		box-sizing: border-box;
		overflow: hidden;
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
</style>
