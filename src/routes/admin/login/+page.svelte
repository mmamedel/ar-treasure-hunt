<script lang="ts">
	import { goto } from '$app/navigation';
	import DecorativeBorder from '$lib/components/DecorativeBorder.svelte';

	let password = $state('');
	let error = $state('');
	let isSubmitting = $state(false);

	async function handleLogin() {
		if (!password) {
			error = 'Digite a senha';
			return;
		}

		isSubmitting = true;
		error = '';

		try {
			const response = await fetch('/api/admin/login', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ password })
			});

			const data = await response.json();

			if (response.ok) {
				goto('/admin');
			} else {
				error = data.error || 'Senha incorreta';
			}
		} catch (err) {
			error = 'Erro ao fazer login';
		} finally {
			isSubmitting = false;
		}
	}

	function handleKeyPress(event: KeyboardEvent) {
		if (event.key === 'Enter') {
			handleLogin();
		}
	}
</script>

<svelte:head>
	<title>Admin Login - Caça ao Tesouro</title>
</svelte:head>

<DecorativeBorder />

<div class="container">
	<div class="logo">
		<img src="/images/design/map-scroll.png" alt="Admin" />
	</div>

	<h1>ADMIN</h1>
	<p class="subtitle">Digite a senha para acessar</p>

	<div class="input-group">
		<input
			type="password"
			placeholder="Senha"
			bind:value={password}
			onkeypress={handleKeyPress}
			disabled={isSubmitting}
		/>
		{#if error}
			<p class="error-message">⚠️ {error}</p>
		{/if}
	</div>

	<button class="button" onclick={handleLogin} disabled={isSubmitting || !password}>
		{isSubmitting ? 'ENTRANDO...' : 'ENTRAR'}
	</button>
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
	}

	.logo img {
		width: 100%;
		height: 100%;
		object-fit: contain;
		filter: drop-shadow(0 4px 6px rgba(0, 0, 0, 0.1));
	}

	h1 {
		font-family: var(--font-primary);
		font-size: 48px;
		font-weight: 400;
		color: var(--color-primary);
		margin: 20px 0 10px;
		text-align: center;
		letter-spacing: 2px;
	}

	.subtitle {
		font-family: var(--font-secondary);
		font-size: 16px;
		color: var(--color-secondary);
		margin: 0 0 40px 0;
		text-align: center;
	}

	.input-group {
		width: 100%;
		max-width: 300px;
		margin-bottom: 20px;
	}

	input {
		width: 100%;
		padding: 15px 20px;
		font-family: var(--font-secondary);
		font-size: 16px;
		background: white;
		color: var(--color-primary);
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		box-sizing: border-box;
		transition: border-color 0.3s;
	}

	input::placeholder {
		color: var(--color-primary);
		opacity: 0.6;
	}

	input:focus {
		outline: none;
		border-color: var(--color-accent);
	}

	input:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.error-message {
		font-family: var(--font-secondary);
		font-size: 14px;
		margin: 8px 0 0 0;
		color: #d06243;
		text-align: center;
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

	@media (max-width: 768px) {
		.container {
			padding: 15px;
			padding-top: 40px;
		}

		.logo {
			width: 100px;
			height: 100px;
			margin: 40px auto 15px;
		}

		h1 {
			font-size: 36px;
			margin: 15px 0 8px;
		}

		.subtitle {
			font-size: 14px;
			margin: 0 0 30px 0;
		}

		.input-group {
			max-width: 280px;
			margin-bottom: 15px;
		}

		input {
			padding: 12px 16px;
			font-size: 15px;
		}

		.error-message {
			font-size: 13px;
			margin: 6px 0 0 0;
		}

		.button {
			width: 100%;
			max-width: 280px;
			padding: 12px 24px;
			font-size: 15px;
		}
	}
</style>
