<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { goto } from '$app/navigation';
	import DecorativeBorder from '$lib/components/DecorativeBorder.svelte';
	import type { LeaderboardEntry } from './+page.server';

	let { data } = $props();

	// Load player info from gameState
	const gameState = getGameState();
	const playerName = gameState?.playerName;

	// Find player in top 100 and calculate rank
	function getPlayerInfo(top100: LeaderboardEntry[]) {
		if (!playerName) return undefined;

		const playerInTop100 = top100.find(
			(entry) => entry.playerName.toLowerCase() === playerName.toLowerCase()
		);

		if (playerInTop100) {
			return {
				playerName: playerInTop100.playerName,
				rank: playerInTop100.rank,
				duration: playerInTop100.duration,
				durationFormatted: playerInTop100.durationFormatted
			};
		}

		return undefined;
	}

	function formatDate(date: Date): string {
		return new Date(date).toLocaleString();
	}

	function getMedalEmoji(rank: number): string {
		if (rank === 1) return '🥇';
		if (rank === 2) return '🥈';
		if (rank === 3) return '🥉';
		return '';
	}

	function handleBack() {
		goto('/');
	}
</script>

<svelte:head>
	<title>Ranking - Caça ao Tesouro</title>
</svelte:head>

<DecorativeBorder />

<div class="container">
	<div class="header">
		<div></div>
		<button class="back-button" onclick={handleBack}>«</button>
		<h1>🏆 Ranking</h1>
		<p class="subtitle">Top 100 Jogadores Mais Rápidos</p>
	</div>

	{#await data.top100}
		<!-- Loading skeleton -->
		<div class="leaderboard-wrapper">
			<table class="leaderboard-table">
				<thead>
					<tr>
						<th class="rank-col">Rank</th>
						<th class="name-col">Nome</th>
						<th class="start-col">Início</th>
						<th class="end-col">Fim</th>
						<th class="duration-col">Tempo de Jogo</th>
					</tr>
				</thead>
				<tbody>
					{#each Array(10) as _, i}
						<tr class="skeleton-row">
							<td class="rank-col">
								<div class="skeleton-item skeleton-rank"></div>
							</td>
							<td class="name-col">
								<div class="skeleton-item skeleton-name"></div>
							</td>
							<td class="start-col">
								<div class="skeleton-item skeleton-date"></div>
							</td>
							<td class="end-col">
								<div class="skeleton-item skeleton-date"></div>
							</td>
							<td class="duration-col">
								<div class="skeleton-item skeleton-duration"></div>
							</td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>
	{:then top100}
		<!-- Loaded data -->
		{@const playerInfo = getPlayerInfo(top100)}

		{#if playerInfo}
			<div class="player-highlight">
				<div class="highlight-content">
					<div class="highlight-rank">#{playerInfo.rank}</div>
					<div class="highlight-info">
						<h2>{playerInfo.playerName}</h2>
						<p class="highlight-duration">{playerInfo.durationFormatted}</p>
					</div>
				</div>
			</div>
		{/if}

		<div class="leaderboard-wrapper">
			<table class="leaderboard-table">
				<thead>
					<tr>
						<th class="rank-col">Rank</th>
						<th class="name-col">Nome</th>
						<th class="start-col">Início</th>
						<th class="end-col">Fim</th>
						<th class="duration-col">Tempo de Jogo</th>
					</tr>
				</thead>
				<tbody>
					{#each top100 as entry (entry.rank)}
						<tr class={playerInfo?.playerName === entry.playerName ? 'highlighted' : ''}>
							<td class="rank-col">
								<div class="rank-cell">
									{#if entry.rank <= 3}
										<span class="medal">{getMedalEmoji(entry.rank)}</span>
									{/if}
									<span class="rank-number">#{entry.rank}</span>
								</div>
							</td>
							<td class="name-col">
								<span class="player-name">{entry.playerName}</span>
							</td>
							<td class="start-col">
								<span class="timestamp">{formatDate(entry.startTime)}</span>
							</td>
							<td class="end-col">
								<span class="timestamp">{formatDate(entry.endTime)}</span>
							</td>
							<td class="duration-col">
								<span class="duration">{entry.durationFormatted}</span>
							</td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>
	{:catch error}
		<!-- Error state -->
		<div class="error-message">
			<p>❌ Erro ao carregar ranking</p>
			<p class="error-detail">{error.message}</p>
		</div>
	{/await}
</div>

<style>
	.container {
		width: 100%;
		height: 100vh;
		padding: 2rem;
		padding-top: 5rem;
		padding-bottom: 2rem;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 1.5rem;
		box-sizing: border-box;
		overflow-y: auto;
		overscroll-behavior-y: contain;
	}

	.header {
		text-align: center;
		color: var(--color-primary);
		margin-bottom: 0;
		margin-top: 4rem;
	}

	.header h1 {
		margin: 0;
		font-size: 2.5rem;
		font-weight: 700;
		font-family: var(--font-primary);
	}

	.subtitle {
		margin: 0.5rem 0 0 0;
		font-size: 1rem;
		color: var(--color-secondary);
		font-family: var(--font-primary);
	}

	.player-highlight {
		width: 100%;
		max-width: 1000px;
		margin-top: 2rem;
		padding: 0.5rem 0;
		background: white;
		border-radius: 12px;
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
		border-left: 5px solid var(--color-accent);
	}

	.highlight-content {
		display: flex;
		align-items: center;
		padding: 0 1rem;
		gap: 1.5rem;
	}

	.highlight-rank {
		font-size: 2rem;
		font-weight: 700;
		color: var(--color-accent);
		font-family: var(--font-secondary);
		min-width: 80px;
	}

	.highlight-info h2 {
		margin: 0;
		color: #333;
		font-size: 1.25rem;
	}

	.highlight-duration {
		margin: 0.5rem 0 0 0;
		color: #666;
		font-size: 0.95rem;
	}

	.leaderboard-wrapper {
		width: 100%;
		max-width: 1000px;
		max-height: 70vh;
		background: white;
		border-radius: 12px;
		box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
		overflow-y: auto;
		overflow-x: auto;
		scroll-behavior: smooth;
	}

	.leaderboard-table {
		width: 100%;
		border-collapse: collapse;
		font-size: 0.95rem;
		font-family: var(--font-secondary);
	}

	.leaderboard-table thead {
		background: var(--color-accent);
		color: var(--color-primary);
		font-family: var(--font-secondary);
		position: sticky;
		top: 0;
		z-index: 10;
	}

	.leaderboard-table th {
		padding: 1.25rem;
		font-weight: 600;
		text-align: left;
		letter-spacing: 0.5px;
	}

	.leaderboard-table tbody tr {
		border-bottom: 1px solid #e0e0e0;
		transition: background-color 0.2s ease;
	}

	.leaderboard-table tbody tr:hover {
		background-color: #f8f9fa;
	}

	.leaderboard-table tbody tr.highlighted {
		background-color: #f5e6d3;
		font-weight: 600;
	}

	.leaderboard-table tbody tr.highlighted:hover {
		background-color: #ead5b8;
	}

	.leaderboard-table td {
		padding: 1.25rem;
	}

	.rank-col {
		width: 100px;
	}

	.rank-cell {
		display: flex;
		align-items: center;
		gap: 0.5rem;
	}

	.medal {
		font-size: 1.25rem;
	}

	.rank-number {
		font-weight: 700;
		color: var(--color-accent);
	}

	.name-col {
		width: 200px;
	}

	.player-name {
		font-weight: 500;
		color: #333;
	}

	.start-col {
		width: 200px;
	}

	.end-col {
		width: 200px;
	}

	.timestamp {
		color: #666;
		font-size: 0.9rem;
	}

	.duration-col {
		width: 120px;
	}

	.duration {
		font-weight: 600;
		color: var(--color-accent);
	}

	@media (max-width: 1200px) {
		.leaderboard-table {
			font-size: 0.85rem;
		}

		.leaderboard-table th,
		.leaderboard-table td {
			padding: 0.875rem;
		}

		.header h1 {
			font-size: 2rem;
		}
	}

	@media (max-width: 768px) {
		.container {
			padding: 1rem;
		}

		.header h1 {
			font-size: 1.5rem;
		}

		.highlight-content {
			gap: 1rem;
		}

		.highlight-rank {
			font-size: 1.5rem;
			min-width: 60px;
		}

		.highlight-info h2 {
			font-size: 1rem;
		}

		.leaderboard-wrapper {
			max-height: 60vh;
		}

		.leaderboard-table {
			font-size: 0.8rem;
		}

		.leaderboard-table th,
		.leaderboard-table td {
			padding: 0.75rem;
		}

		.rank-col {
			width: 80px;
		}

		.name-col {
			width: auto;
		}

		.start-col,
		.end-col {
			display: none;
		}

		.duration-col {
			width: 100px;
		}
	}

	.back-button {
		position: fixed;
		top: 3rem;
		left: 1.5rem;
		width: 3.5rem;
		height: 3.5rem;
		border-radius: 50%;
		background: var(--color-accent);
		color: var(--color-primary);
		border: var(--border-width) solid var(--color-border);
		font-size: 28px;
		font-family: var(--font-primary);
		cursor: pointer;
		z-index: 100;
		display: flex;
		align-items: center;
		justify-content: center;
		box-shadow: 0 4px 12px rgba(208, 141, 61, 0.4);
		transition: all 0.3s ease;
	}

	.back-button:hover {
		transform: scale(1.1);
		box-shadow: 0 6px 20px rgba(208, 141, 61, 0.6);
	}

	/* Skeleton loader styles */
	.skeleton-row {
		background: rgba(255, 255, 255, 0.6);
	}

	.skeleton-item {
		background: linear-gradient(
			90deg,
			rgba(208, 141, 61, 0.1) 0%,
			rgba(208, 141, 61, 0.2) 50%,
			rgba(208, 141, 61, 0.1) 100%
		);
		background-size: 200% 100%;
		animation: skeleton-loading 1.5s ease-in-out infinite;
		border-radius: 4px;
		height: 16px;
	}

	.skeleton-rank {
		width: 50px;
		margin: 0 auto;
	}

	.skeleton-name {
		width: 80%;
		max-width: 150px;
	}

	.skeleton-date {
		width: 90%;
		max-width: 120px;
	}

	.skeleton-duration {
		width: 70px;
		margin: 0 auto;
	}

	@keyframes skeleton-loading {
		0% {
			background-position: 200% 0;
		}
		100% {
			background-position: -200% 0;
		}
	}

	/* Error message styles */
	.error-message {
		text-align: center;
		padding: 2rem;
		color: var(--color-primary);
	}

	.error-message p {
		margin: 0.5rem 0;
		font-family: var(--font-secondary);
	}

	.error-detail {
		font-size: 0.9rem;
		color: var(--color-secondary);
	}
</style>
