<script lang="ts">
	import type { PageData } from './$types';

	let { data } = $props();

	const { prizeStatus } = data;

	function formatDate(date: Date | undefined): string {
		if (!date) return 'N/A';
		return new Date(date).toLocaleString();
	}
</script>

<svelte:head>
	<title>Prize Distribution - Support Portal</title>
</svelte:head>

<div class="container">
	<div class="header">
		<h1>Prize Distribution Check</h1>
		<p class="subtitle">Support Personnel Portal</p>
	</div>

	<div class="card">
		<div class="player-info">
			<h2>Player: {prizeStatus.playerName}</h2>
		</div>

		<div class="status-section">
			<div class="status-grid">
				<div class="status-item">
					<span class="status-label">Game Status</span>
					<span class={prizeStatus.isFinished ? 'status-badge finished' : 'status-badge pending'}>
						{prizeStatus.isFinished ? '✓ Finished' : '⏳ In Progress'}
					</span>
				</div>

				<div class="status-item">
					<span class="status-label">Prize Status</span>
					<span
						class={prizeStatus.hasReceivedPrize ? 'status-badge received' : 'status-badge pending'}
					>
						{prizeStatus.hasReceivedPrize ? '✓ Received' : '⊘ Not Received'}
					</span>
				</div>
			</div>

			<div class="timing-info">
				{#if prizeStatus.startTime}
					<p>
						<strong>Started:</strong>
						{formatDate(prizeStatus.startTime)}
					</p>
				{/if}
				{#if prizeStatus.endTime}
					<p>
						<strong>Finished:</strong>
						{formatDate(prizeStatus.endTime)}
					</p>
				{/if}
			</div>
		</div>

		<div class="message-section">
			<div class={`message ${prizeStatus.eligibleForPrize ? 'eligible' : 'ineligible'}`}>
				<div class="message-icon">
					{#if prizeStatus.eligibleForPrize}
						✅
					{:else}
						⚠️
					{/if}
				</div>
				<div class="message-content">
					<p>{prizeStatus.message}</p>
				</div>
			</div>
		</div>

		{#if prizeStatus.eligibleForPrize}
			<div class="action-section">
				<button class="btn-primary">Mark Prize as Delivered</button>
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

	.status-item label {
		font-weight: 600;
		color: #666;
		font-size: 0.875rem;
		text-transform: uppercase;
		letter-spacing: 0.5px;
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
	}

	.btn-primary:hover {
		transform: translateY(-2px);
		box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
	}

	.btn-primary:active {
		transform: translateY(0);
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
