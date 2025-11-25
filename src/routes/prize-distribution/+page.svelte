<script lang="ts">
	let { data } = $props();

	const { prizeStatus } = data;

	let isMarking = $state(false);
	let successMessage = $state('');
	let errorMessage = $state('');

	let prizeStatusState = $state(prizeStatus);

	function formatDate(date: Date | undefined): string {
		if (!date) return 'N/A';
		return new Date(date).toLocaleString();
	}

	async function markPrizeAsDelivered() {
		isMarking = true;
		errorMessage = '';
		successMessage = '';

		try {
			const response = await fetch('/api/prize/mark-delivered', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({
					playerName: prizeStatusState.playerName
				})
			});

			if (!response.ok) {
				const error = await response.json();
				errorMessage = error.error || 'Falha ao marcar prêmio como entregue';
				isMarking = false;
				return;
			}

			const result = await response.json();
			successMessage = result.message || 'Prêmio marcado como entregue com sucesso!';

			// Update the local status
			prizeStatusState.hasReceivedPrize = true;
			prizeStatusState.message = 'Este jogador já recebeu seu prêmio.';
			prizeStatusState.eligibleForPrize = false;

			isMarking = false;
			// Reload page data after 2 seconds
			/* setTimeout(() => {
				window.location.reload();
			}, 2000); */
		} catch (error) {
			console.error('Error marking prize as delivered:', error);
			errorMessage = 'Ocorreu um erro. Por favor, tente novamente.';
			isMarking = false;
		}
	}
</script>

<svelte:head>
	<title>Distribuição de Prêmios - Portal de Suporte</title>
</svelte:head>

<div class="container">
	<div class="header">
		<h1>Verificação de Distribuição de Prêmios</h1>
		<p class="subtitle">Portal de Equipe de Suporte</p>
	</div>

	<div class="card">
		<div class="player-info">
			<h2>Jogador: {prizeStatusState.playerName}</h2>
		</div>

		<div class="status-section">
			<div class="status-grid">
				<div class="status-item">
					<span class="status-label">Status do Jogo</span>
					<span
						class={prizeStatusState.isFinished ? 'status-badge finished' : 'status-badge pending'}
					>
						{prizeStatusState.isFinished ? '✓ Finalizado' : '⏳ Em Andamento'}
					</span>
				</div>

				<div class="status-item">
					<span class="status-label">Status do Prêmio</span>
					<span
						class={prizeStatusState.hasReceivedPrize
							? 'status-badge received'
							: 'status-badge pending'}
					>
						{prizeStatusState.hasReceivedPrize ? '✓ Recebido' : '⊘ Não Recebido'}
					</span>
				</div>
			</div>

			<div class="timing-info">
				{#if prizeStatusState.startTime}
					<p>
						<strong>Iniciado:</strong>
						{formatDate(prizeStatusState.startTime)}
					</p>
				{/if}
				{#if prizeStatusState.endTime}
					<p>
						<strong>Finalizado:</strong>
						{formatDate(prizeStatusState.endTime)}
					</p>
				{/if}
			</div>
		</div>

		<div class="message-section">
			<div class={`message ${prizeStatusState.eligibleForPrize ? 'eligible' : 'ineligible'}`}>
				<div class="message-icon">
					{#if prizeStatusState.eligibleForPrize}
						✅
					{:else}
						⚠️
					{/if}
				</div>
				<div class="message-content">
					<p>{prizeStatusState.message}</p>
				</div>
			</div>

			{#if successMessage}
				<div class="message success-message">
					<div class="message-icon">✓</div>
					<div class="message-content">
						<p>{successMessage}</p>
					</div>
				</div>
			{/if}

			{#if errorMessage}
				<div class="message error-message">
					<div class="message-icon">✕</div>
					<div class="message-content">
						<p>{errorMessage}</p>
					</div>
				</div>
			{/if}
		</div>

		{#if prizeStatusState.eligibleForPrize && !successMessage}
			<div class="action-section">
				<button class="btn-primary" onclick={markPrizeAsDelivered} disabled={isMarking}>
					{#if isMarking}
						<span class="spinner"></span>
						Marcando...
					{:else}
						✓ Marcar Prêmio como Entregue
					{/if}
				</button>
			</div>
		{/if}
	</div>
</div>

<style>
	.container {
		width: 100%;
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 2rem;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	}

	.header {
		text-align: center;
		margin-bottom: 2rem;
		color: white;
	}

	.header h1 {
		margin: 0;
		font-size: 2.5rem;
		font-weight: 700;
	}

	.subtitle {
		margin: 0.5rem 0 0 0;
		font-size: 1rem;
		opacity: 0.9;
	}

	.card {
		width: 100%;
		max-width: 600px;
		background: white;
		border-radius: 12px;
		box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
		overflow: hidden;
	}

	.player-info {
		padding: 2rem;
		background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
		border-bottom: 2px solid #e0e0e0;
	}

	.player-info h2 {
		margin: 0;
		color: #333;
		font-size: 1.5rem;
	}

	.status-section {
		padding: 2rem;
	}

	.status-grid {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 1.5rem;
		margin-bottom: 1.5rem;
	}

	.status-item {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
	}

	.status-label {
		font-weight: 600;
		color: #666;
		font-size: 0.875rem;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.status-badge {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		padding: 0.5rem 1rem;
		border-radius: 6px;
		font-weight: 600;
		font-size: 0.875rem;
	}

	.status-badge.finished {
		background: #d4edda;
		color: #155724;
	}

	.status-badge.received {
		background: #d4edda;
		color: #155724;
	}

	.status-badge.pending {
		background: #fff3cd;
		color: #856404;
	}

	.timing-info {
		padding-top: 1.5rem;
		border-top: 1px solid #e0e0e0;
	}

	.timing-info p {
		margin: 0.5rem 0;
		color: #666;
		font-size: 0.95rem;
	}

	.timing-info strong {
		color: #333;
	}

	.message-section {
		padding: 2rem;
		background: #f8f9fa;
		border-top: 1px solid #e0e0e0;
	}

	.message {
		display: flex;
		gap: 1rem;
		padding: 1.5rem;
		border-radius: 8px;
		align-items: flex-start;
	}

	.message.eligible {
		background: #d4edda;
		border: 1px solid #c3e6cb;
		color: #155724;
	}

	.message.ineligible {
		background: #fff3cd;
		border: 1px solid #ffeaa7;
		color: #856404;
	}

	.message-icon {
		font-size: 1.5rem;
		flex-shrink: 0;
	}

	.message-content p {
		margin: 0;
		font-weight: 500;
		line-height: 1.4;
	}

	.action-section {
		padding: 2rem;
		background: #f8f9fa;
		border-top: 1px solid #e0e0e0;
		display: flex;
		gap: 1rem;
	}

	.btn-primary {
		flex: 1;
		padding: 0.875rem 1.5rem;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		border: none;
		border-radius: 6px;
		font-weight: 600;
		font-size: 1rem;
		cursor: pointer;
		transition: all 0.3s ease;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 0.5rem;
	}

	.btn-primary:hover:not(:disabled) {
		transform: translateY(-2px);
		box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
	}

	.btn-primary:active:not(:disabled) {
		transform: translateY(0);
	}

	.btn-primary:disabled {
		opacity: 0.7;
		cursor: not-allowed;
	}

	.spinner {
		display: inline-block;
		width: 1rem;
		height: 1rem;
		border: 2px solid rgba(255, 255, 255, 0.3);
		border-top: 2px solid white;
		border-radius: 50%;
		animation: spin 0.8s linear infinite;
	}

	@keyframes spin {
		to {
			transform: rotate(360deg);
		}
	}

	.message.success-message {
		background: #d4edda;
		border: 1px solid #c3e6cb;
		color: #155724;
		margin-top: 1rem;
	}

	.message.error-message {
		background: #f8d7da;
		border: 1px solid #f5c6cb;
		color: #721c24;
		margin-top: 1rem;
	}

	@media (max-width: 600px) {
		.header h1 {
			font-size: 1.75rem;
		}

		.status-grid {
			grid-template-columns: 1fr;
		}

		.container {
			padding: 1rem;
		}
	}
</style>
