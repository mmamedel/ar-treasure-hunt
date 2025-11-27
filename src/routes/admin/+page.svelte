<script lang="ts">
	import { goto } from '$app/navigation';
	import DecorativeBorder from '$lib/components/DecorativeBorder.svelte';

	let { data } = $props();

	let startTime = $state('');
	let endTime = $state('');
	let message = $state('');
	let error = $state('');
	let isSubmitting = $state(false);
	let gameStatus = $state<'loading' | 'before_start' | 'active' | 'ended' | 'no_config'>('loading');

	// Session management
	let searchQuery = $state('');
	let sessions = $state<any[]>([]);
	let isSearching = $state(false);
	let searchError = $state('');
	let editingSessionId = $state<number | null>(null);
	let editingNameOverride = $state('');

	// Treasure statistics
	let treasureStats = $state<any[]>([]);
	let isLoadingStats = $state(false);

	$effect(() => {
		if (data.config) {
			// Convert ISO strings to datetime-local format
			startTime = data.config.startTime.slice(0, 16);
			endTime = data.config.endTime.slice(0, 16);
		} else {
			// Set defaults: start now, end in 24 hours
			const now = new Date();
			const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
			startTime = now.toISOString().slice(0, 16);
			endTime = tomorrow.toISOString().slice(0, 16);
		}

		checkGameStatus();
		loadTreasureStats();
	});

	async function checkGameStatus() {
		try {
			const response = await fetch('/api/game-config');
			const data = await response.json();
			gameStatus = data.exists ? data.status : 'no_config';
		} catch (err) {
			gameStatus = 'no_config';
		}
	}

	async function loadTreasureStats() {
		isLoadingStats = true;
		try {
			const response = await fetch('/api/admin/treasure-stats');
			const data = await response.json();

			if (response.ok) {
				treasureStats = data.stats;
			}
		} catch (err) {
			console.error('Error loading treasure stats:', err);
		} finally {
			isLoadingStats = false;
		}
	}

	async function handleSave() {
		error = '';
		message = '';

		if (!startTime || !endTime) {
			error = 'Preencha ambas as datas';
			return;
		}

		const start = new Date(startTime);
		const end = new Date(endTime);

		if (start >= end) {
			error = 'Data de início deve ser anterior à data de fim';
			return;
		}

		isSubmitting = true;

		try {
			const response = await fetch('/api/admin/game-config', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({
					startTime: start.toISOString(),
					endTime: end.toISOString()
				})
			});

			const data = await response.json();

			if (response.ok) {
				message = '✅ Configuração salva com sucesso!';
				await checkGameStatus();
			} else {
				error = data.error || 'Erro ao salvar configuração';
			}
		} catch (err) {
			error = 'Erro ao salvar configuração';
		} finally {
			isSubmitting = false;
		}
	}

	async function handleDelete() {
		if (!confirm('Tem certeza que deseja remover a configuração? O jogo ficará sempre ativo.')) {
			return;
		}

		isSubmitting = true;
		error = '';
		message = '';

		try {
			const response = await fetch('/api/admin/game-config', {
				method: 'DELETE'
			});

			const data = await response.json();

			if (response.ok) {
				message = '✅ Configuração removida com sucesso!';
				// Set defaults
				const now = new Date();
				const tomorrow = new Date(now.getTime() + 24 * 60 * 60 * 1000);
				startTime = now.toISOString().slice(0, 16);
				endTime = tomorrow.toISOString().slice(0, 16);
				await checkGameStatus();
			} else {
				error = data.error || 'Erro ao remover configuração';
			}
		} catch (err) {
			error = 'Erro ao remover configuração';
		} finally {
			isSubmitting = false;
		}
	}

	async function handleLogout() {
		try {
			await fetch('/api/admin/logout', {
				method: 'POST'
			});
		} catch (err) {
			console.error('Error logging out:', err);
		} finally {
			// Always redirect even if logout fails
			goto('/admin/login');
		}
	}

	function handleRestart() {
		if (confirm('Isso vai limpar toda a sessão de jogo armazenada localmente. Tem certeza?')) {
			// Navigate to restart route which will clear session and redirect
			goto('/restart');
		}
	}

	async function handleSearchSessions() {
		if (!searchQuery.trim()) {
			searchError = 'Digite um nome para buscar';
			return;
		}

		isSearching = true;
		searchError = '';
		sessions = [];

		try {
			const response = await fetch(
				`/api/admin/sessions/search?q=${encodeURIComponent(searchQuery)}`
			);
			const data = await response.json();

			if (response.ok) {
				sessions = data.sessions;
				if (sessions.length === 0) {
					searchError = 'Nenhuma sessão encontrada';
				}
			} else {
				searchError = data.error || 'Erro ao buscar sessões';
			}
		} catch (err) {
			searchError = 'Erro ao buscar sessões';
		} finally {
			isSearching = false;
		}
	}

	function startEditSession(session: any) {
		editingSessionId = session.id;
		editingNameOverride = session.nameOverride ?? '';
	}

	function cancelEdit() {
		editingSessionId = null;
		editingNameOverride = '';
	}

	async function saveNameOverride(sessionId: number) {
		try {
			const response = await fetch(`/api/admin/sessions/${sessionId}`, {
				method: 'PATCH',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({
					nameOverride: editingNameOverride.trim() || null
				})
			});

			const data = await response.json();

			if (response.ok) {
				// Update the session in the list
				sessions = sessions.map((s) =>
					s.id === sessionId
						? {
								...s,
								nameOverride: data.session.nameOverride,
								displayName: data.session.displayName
							}
						: s
				);
				editingSessionId = null;
				editingNameOverride = '';
			} else {
				alert(data.error || 'Erro ao atualizar nome');
			}
		} catch (err) {
			alert('Erro ao atualizar nome');
		}
	}

	function getStatusLabel(status: string) {
		switch (status) {
			case 'before_start':
				return '⏳ Aguardando início';
			case 'active':
				return '✅ Ativo';
			case 'ended':
				return '🏁 Finalizado';
			case 'no_config':
				return '⚠️ Sem configuração (sempre ativo)';
			default:
				return '...';
		}
	}

	function getStatusColor(status: string) {
		switch (status) {
			case 'before_start':
				return '#d08d3d';
			case 'active':
				return '#5e928a';
			case 'ended':
				return '#d06243';
			case 'no_config':
				return '#656565';
			default:
				return '#656565';
		}
	}
</script>

<svelte:head>
	<title>Admin - Caça ao Tesouro</title>
</svelte:head>

<DecorativeBorder />

<div class="container">
	<div class="header">
		<h1>⚙️ ADMIN</h1>
		<p class="subtitle">Configuração do Jogo</p>
		<div class="header-buttons">
			<button class="restart-button" onclick={handleRestart}> 🔄 Reiniciar Jogo </button>
			<button class="logout-button" onclick={handleLogout}>Sair</button>
		</div>
	</div>

	<div class="status-card" style="border-color: {getStatusColor(gameStatus)}">
		<p class="status-label">Status do Jogo:</p>
		<p class="status-value" style="color: {getStatusColor(gameStatus)}">
			{getStatusLabel(gameStatus)}
		</p>
	</div>

	<div class="form-card">
		<div class="form-group">
			<label for="start-time">Data e Hora de Início</label>
			<input type="datetime-local" id="start-time" bind:value={startTime} disabled={isSubmitting} />
		</div>

		<div class="form-group">
			<label for="end-time">Data e Hora de Fim</label>
			<input type="datetime-local" id="end-time" bind:value={endTime} disabled={isSubmitting} />
		</div>

		{#if message}
			<p class="success-message">{message}</p>
		{/if}

		{#if error}
			<p class="error-message">⚠️ {error}</p>
		{/if}

		<div class="button-group">
			<button class="button primary" onclick={handleSave} disabled={isSubmitting}>
				{isSubmitting ? 'SALVANDO...' : 'SALVAR CONFIGURAÇÃO'}
			</button>

			<button class="button secondary" onclick={handleDelete} disabled={isSubmitting}>
				REMOVER CONFIGURAÇÃO
			</button>
		</div>
	</div>

	<div class="form-card stats-card">
		<h3>📊 Estatísticas dos Tesouros</h3>
		<p class="stats-info">Tempo médio, mínimo e máximo para encontrar cada tesouro</p>

		{#if isLoadingStats}
			<p class="loading-text">Carregando estatísticas...</p>
		{:else if treasureStats.length === 0}
			<p class="no-data-text">Nenhum tesouro encontrado ainda</p>
		{:else}
			<div class="stats-table-container">
				<table class="stats-table">
					<thead>
						<tr>
							<th>Tesouro</th>
							<th>Tentativas</th>
							<th>Média</th>
							<th>Mínimo</th>
							<th>Máximo</th>
						</tr>
					</thead>
					<tbody>
						{#each treasureStats as stat}
							<tr>
								<td class="treasure-emoji">{stat.emoji}</td>
								<td>{stat.count}</td>
								<td>{stat.averageFormatted}</td>
								<td class="min-time">{stat.minFormatted}</td>
								<td class="max-time">{stat.maxFormatted}</td>
							</tr>
						{/each}
					</tbody>
				</table>
			</div>
		{/if}
	</div>

	<div class="form-card sessions-card">
		<h3>👤 Gerenciar Nomes de Jogadores</h3>
		<p class="session-info">Busque e modifique nomes inadequados que aparecem no ranking</p>

		<div class="search-section">
			<div class="search-input-group">
				<input
					type="text"
					placeholder="Buscar por nome original ou modificado..."
					bind:value={searchQuery}
					disabled={isSearching}
					onkeydown={(e) => e.key === 'Enter' && handleSearchSessions()}
				/>
				<button class="button search-button" onclick={handleSearchSessions} disabled={isSearching}>
					{isSearching ? '🔍...' : '🔍 Buscar'}
				</button>
			</div>

			{#if searchError}
				<p class="error-message">{searchError}</p>
			{/if}
		</div>

		{#if sessions.length > 0}
			<div class="sessions-list">
				<h4>Resultados ({sessions.length})</h4>
				{#each sessions as session}
					<div class="session-item">
						<div class="session-info-row">
							<strong>Nome Original:</strong>
							{session.playerName}
						</div>

						{#if editingSessionId === session.id}
							<div class="edit-section">
								<label for="override-{session.id}">Nome para Exibição:</label>
								<input
									type="text"
									id="override-{session.id}"
									bind:value={editingNameOverride}
									placeholder="Deixe vazio para usar nome original"
								/>
								<div class="edit-buttons">
									<button class="button small" onclick={() => saveNameOverride(session.id)}>
										✓ Salvar
									</button>
									<button class="button secondary small" onclick={cancelEdit}>✗ Cancelar</button>
								</div>
							</div>
						{:else}
							<div class="session-info-row">
								<strong>Exibido como:</strong>
								<span class:overridden={session.nameOverride}>{session.displayName}</span>
								{#if session.nameOverride}
									<span class="badge">modificado</span>
								{/if}
							</div>
							<button class="button secondary small" onclick={() => startEditSession(session)}>
								✏️ Editar
							</button>
						{/if}
					</div>
				{/each}
			</div>
		{/if}
	</div>
</div>

<style>
	.container {
		width: 100%;
		min-height: 100vh;
		padding: 2rem;
		padding-top: 5rem;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 2rem;
		box-sizing: border-box;
		overflow-y: auto;
		overscroll-behavior-y: contain;
	}

	.header {
		text-align: center;
		position: relative;
		width: 100%;
		max-width: 600px;
	}

	.header h1 {
		font-family: var(--font-primary);
		font-size: 2.5rem;
		color: var(--color-primary);
		margin: 0;
	}

	.subtitle {
		font-family: var(--font-secondary);
		font-size: 1rem;
		color: var(--color-secondary);
		margin: 0.5rem 0 0 0;
	}

	.header-buttons {
		position: absolute;
		top: 0;
		right: 0;
		display: flex;
		gap: 0.5rem;
	}

	.restart-button,
	.logout-button {
		padding: 0.5rem 1rem;
		font-family: var(--font-secondary);
		font-size: 0.9rem;
		color: white;
		border: none;
		border-radius: var(--radius-md);
		cursor: pointer;
		transition: opacity 0.2s;
	}

	.restart-button {
		background: #d06243;
	}

	.restart-button:disabled {
		opacity: 0.5;
		cursor: not-allowed;
	}

	.logout-button {
		background: var(--color-secondary);
	}

	.restart-button:hover:not(:disabled),
	.logout-button:hover {
		opacity: 0.8;
	}

	.status-card {
		width: 100%;
		max-width: 600px;
		background: white;
		border: 3px solid var(--color-border);
		border-radius: var(--radius-md);
		padding: 1.5rem;
		text-align: center;
		box-sizing: border-box;
	}

	.status-label {
		font-family: var(--font-secondary);
		font-size: 0.9rem;
		color: var(--color-secondary);
		margin: 0 0 0.5rem 0;
	}

	.status-value {
		font-family: var(--font-primary);
		font-size: 1.5rem;
		font-weight: bold;
		margin: 0;
	}

	.form-card {
		width: 100%;
		max-width: 600px;
		background: white;
		border: var(--border-width) solid var(--color-border);
		border-radius: var(--radius-md);
		padding: 2rem;
		box-sizing: border-box;
	}

	.form-group {
		margin-bottom: 1.5rem;
		width: 100%;
		overflow: hidden;
	}

	.form-group label {
		display: block;
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		font-weight: 600;
		color: var(--color-primary);
		margin-bottom: 0.5rem;
	}

	.form-group input {
		width: 100%;
		padding: 10px 14px;
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		background: #f2f2f2;
		color: var(--color-primary);
		border: 2px solid var(--color-border);
		border-radius: var(--radius-sm);
		box-sizing: border-box;
		transition: border-color 0.3s;
		-webkit-appearance: none;
		appearance: none;
		max-width: 100%;
	}

	.form-group input:focus {
		outline: none;
		border-color: var(--color-accent);
	}

	.form-group input:disabled {
		opacity: 0.6;
		cursor: not-allowed;
	}

	.button-group {
		display: flex;
		flex-direction: column;
		gap: 1rem;
		margin-top: 2rem;
	}

	.button {
		width: 100%;
		padding: 15px 30px;
		font-family: var(--font-primary);
		font-size: 16px;
		font-weight: normal;
		border: none;
		border-radius: var(--radius-full);
		cursor: pointer;
		transition:
			transform 0.2s,
			opacity 0.2s;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.button.primary {
		background: var(--color-accent);
		color: var(--color-primary);
	}

	.button.secondary {
		background: var(--color-secondary);
		color: white;
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

	.success-message {
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		color: #5e928a;
		text-align: center;
		margin: 1rem 0;
		padding: 0.75rem;
		background: rgba(94, 146, 138, 0.1);
		border-radius: var(--radius-sm);
	}

	.error-message {
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		color: #d06243;
		text-align: center;
		margin: 1rem 0;
		padding: 0.75rem;
		background: rgba(208, 98, 67, 0.1);
		border-radius: var(--radius-sm);
	}

	/* Session management styles */
	.sessions-card h3 {
		font-family: var(--font-primary);
		font-size: 1.3rem;
		color: var(--color-primary);
		margin: 0 0 0.5rem 0;
	}

	.session-info {
		font-family: var(--font-secondary);
		font-size: 0.9rem;
		color: var(--color-secondary);
		margin: 0 0 1.5rem 0;
	}

	.search-section {
		margin-bottom: 1.5rem;
	}

	.search-input-group {
		display: flex;
		gap: 0.5rem;
		margin-bottom: 0.5rem;
	}

	.search-input-group input {
		flex: 1;
		padding: 10px 14px;
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		background: #f2f2f2;
		color: var(--color-primary);
		border: 2px solid var(--color-border);
		border-radius: var(--radius-sm);
		box-sizing: border-box;
	}

	.search-button {
		white-space: nowrap;
		padding: 10px 20px !important;
	}

	.sessions-list {
		margin-top: 1rem;
	}

	.sessions-list h4 {
		font-family: var(--font-secondary);
		font-size: 1rem;
		color: var(--color-primary);
		margin: 0 0 1rem 0;
	}

	.session-item {
		background: rgba(255, 255, 255, 0.5);
		border: 2px solid var(--color-border);
		border-radius: var(--radius-sm);
		padding: 1rem;
		margin-bottom: 0.75rem;
	}

	.session-info-row {
		font-family: var(--font-secondary);
		font-size: 0.9rem;
		color: var(--color-primary);
		margin-bottom: 0.5rem;
		display: flex;
		align-items: center;
		gap: 0.5rem;
		flex-wrap: wrap;
	}

	.session-info-row strong {
		font-weight: 600;
	}

	.session-info-row .overridden {
		color: var(--color-accent);
		font-weight: 600;
	}

	.badge {
		display: inline-block;
		background: var(--color-accent);
		color: var(--color-primary);
		padding: 2px 8px;
		border-radius: 12px;
		font-size: 0.75rem;
		font-weight: 600;
	}

	.edit-section {
		margin-top: 0.75rem;
	}

	.edit-section label {
		display: block;
		font-family: var(--font-secondary);
		font-size: 0.85rem;
		font-weight: 600;
		color: var(--color-primary);
		margin-bottom: 0.4rem;
	}

	.edit-section input {
		width: 100%;
		padding: 10px 14px;
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		background: white;
		color: var(--color-primary);
		border: 2px solid var(--color-border);
		border-radius: var(--radius-sm);
		box-sizing: border-box;
		margin-bottom: 0.75rem;
	}

	.edit-buttons {
		display: flex;
		gap: 0.5rem;
	}

	.button.small {
		padding: 8px 16px;
		font-size: 14px;
	}

	/* Treasure statistics styles */
	.stats-card h3 {
		font-family: var(--font-primary);
		font-size: 1.3rem;
		color: var(--color-primary);
		margin: 0 0 0.5rem 0;
	}

	.stats-info {
		font-family: var(--font-secondary);
		font-size: 0.9rem;
		color: var(--color-secondary);
		margin: 0 0 1.5rem 0;
	}

	.loading-text,
	.no-data-text {
		font-family: var(--font-secondary);
		font-size: 0.95rem;
		color: var(--color-secondary);
		text-align: center;
		padding: 2rem 0;
		margin: 0;
	}

	.stats-table-container {
		overflow-x: auto;
		margin-top: 1rem;
	}

	.stats-table {
		width: 100%;
		border-collapse: collapse;
		font-family: var(--font-secondary);
	}

	.stats-table thead {
		background: var(--color-accent);
	}

	.stats-table th {
		padding: 12px;
		text-align: left;
		font-weight: 600;
		font-size: 0.9rem;
		color: var(--color-primary);
		border: 2px solid var(--color-border);
	}

	.stats-table td {
		padding: 10px 12px;
		font-size: 0.9rem;
		color: var(--color-primary);
		border: 2px solid var(--color-border);
		background: rgba(255, 255, 255, 0.5);
	}

	.stats-table tbody tr:hover {
		background: rgba(208, 141, 61, 0.2);
	}

	.stats-table .treasure-emoji {
		font-size: 1.5rem;
		text-align: center;
	}

	.stats-table .min-time {
		color: #5e928a;
		font-weight: 600;
	}

	.stats-table .max-time {
		color: #d06243;
		font-weight: 600;
	}

	@media (max-width: 768px) {
		.container {
			padding: 0.5rem;
			padding-top: 4rem;
			gap: 1rem;
		}

		.header h1 {
			font-size: 1.75rem;
		}

		.subtitle {
			font-size: 0.9rem;
		}

		.header-buttons {
			position: static;
			margin-top: 0.75rem;
			flex-direction: column;
			width: 100%;
		}

		.restart-button,
		.logout-button {
			width: 100%;
			padding: 0.6rem 0.75rem;
			font-size: 0.85rem;
		}

		.status-card {
			padding: 0.75rem;
			box-sizing: border-box;
		}

		.status-label {
			font-size: 0.8rem;
		}

		.status-value {
			font-size: 1.25rem;
		}

		.form-card {
			padding: 0.5rem;
			box-sizing: border-box;
		}

		.form-group {
			margin-bottom: 0.75rem;
		}

		.form-group label {
			font-size: 0.8rem;
			margin-bottom: 0.3rem;
		}

		.form-group input {
			padding: 6px 8px;
			font-size: 0.75rem;
			box-sizing: border-box;
			-webkit-appearance: none;
			appearance: none;
			max-width: 100%;
			min-height: 0;
		}

		.button-group {
			margin-top: 1.25rem;
			gap: 0.75rem;
		}

		.button {
			padding: 12px 20px;
			font-size: 14px;
		}

		.success-message,
		.error-message {
			font-size: 0.85rem;
			padding: 0.6rem;
			margin: 0.75rem 0;
		}

		.stats-table th,
		.stats-table td {
			padding: 8px;
			font-size: 0.8rem;
		}

		.stats-table th:first-child,
		.stats-table td:first-child {
			position: sticky;
			left: 0;
			background: var(--color-accent);
			z-index: 1;
		}

		.stats-table td:first-child {
			background: rgba(255, 255, 255, 0.95);
		}
	}

	/* iOS Safari specific fixes */
	@supports (-webkit-touch-callout: none) {
		@media (max-width: 768px) {
			.container {
				padding: 0.4rem;
				padding-top: 4rem;
			}

			.form-card,
			.status-card {
				padding: 0.5rem;
			}

			.form-group input {
				padding: 5px 7px;
				font-size: 14px;
				min-height: 38px;
			}

			.form-group input[type='datetime-local'] {
				min-width: 0;
				width: 100%;
			}
		}
	}
</style>
