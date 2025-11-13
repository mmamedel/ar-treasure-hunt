<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { Debounced } from 'runed';

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

<div class="container">
	<div class="logo">🗺️</div>
	<h1>Caça ao Tesouro AR</h1>
	<p class="subtitle">Digite seu nome para começar a aventura</p>

	<div class="input-group">
		<input
			type="text"
			placeholder="Seu nome"
			maxlength="20"
			bind:value={playerName}
			onkeypress={handleKeyPress}
		/>
		{#if validationMessage && !isValid && playerName.trim().length > 0}
			<p
				class="validation-message"
				class:error={!isValid && playerName.trim().length > 0}
				class:pending={isChecking}
			>
				{validationMessage}
			</p>
		{/if}
	</div>

	<button class="button" disabled={!isValid || !hasCheckedCurrentName} onclick={handleSubmit}>
		{'Começar Aventura'}
	</button>

	<p class="info">💡 Este nome aparecerá no placar</p>
</div>

<style>
	.container {
		display: flex;
		flex-direction: column;
		width: 100%;
		max-width: 400px;
		text-align: center;
		margin: 0 auto;
	}

	.logo {
		width: 120px;
		height: 120px;
		background: rgba(255, 255, 255, 0.2);
		border-radius: 50%;
		margin: 0 auto 30px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 48px;
	}

	h1 {
		font-size: 28px;
		margin-bottom: 10px;
	}

	.subtitle {
		font-size: 16px;
		opacity: 0.9;
		margin-bottom: 40px;
	}

	.input-group {
		display: flex;
		flex-direction: column;
		margin-bottom: 2rem;
	}

	input {
		width: 100%;
		padding: 15px 0px;
		font-size: 18px;
		border: none;
		border-radius: 10px;
		background: rgba(255, 255, 255, 0.95);
		color: #333;
		text-align: center;
	}

	input::placeholder {
		color: #999;
	}

	.validation-message {
		font-size: 14px;
		margin: 0.5rem 0 0 0;
		color: #4caf50;
	}

	.validation-message.error {
		color: #ff6b6b;
	}

	.validation-message.pending {
		color: #ffa500;
	}

	.button {
		width: 100%;
		padding: 15px 30px;
		font-size: 18px;
		font-weight: 600;
		background: #4caf50;
		color: white;
		border: none;
		border-radius: 10px;
		cursor: pointer;
		transition: transform 0.2s;
	}

	.button:hover:not(:disabled) {
		transform: scale(1.05);
	}

	.button:disabled {
		background: #ccc;
		cursor: not-allowed;
		transform: none;
	}

	.info {
		margin-top: 30px;
		font-size: 14px;
		opacity: 0.8;
	}
</style>
