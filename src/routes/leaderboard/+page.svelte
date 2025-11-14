<script lang="ts">
	import { getGameState } from '$lib/stores/gameState.svelte';
	import { goto } from '$app/navigation';

	let { data } = $props();

	const { top50 } = data;

	// Load player info from gameState
	const gameState = getGameState();
	const playerName = gameState?.playerName;

	// Find player in top 50 and calculate rank
	let playerInfo = $derived.by(() => {
		if (!playerName) return undefined;

		const playerInTop50 = top50.find(
			(entry) => entry.playerName.toLowerCase() === playerName.toLowerCase()
		);

		if (playerInTop50) {
			return {
				playerName: playerInTop50.playerName,
				rank: playerInTop50.rank,
				duration: playerInTop50.duration,
				durationFormatted: playerInTop50.durationFormatted
			};
		}

		return undefined;
	});

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
	<title>Ranking - AR Treasure Hunt</title>
</svelte:head>

<div class="container">
	<div class="header">
		<div></div>
		<button class="back-button" onclick={handleBack}>«</button>
		<h1>🏆 Ranking</h1>
		<p class="subtitle">Top 50 Jogadores Mais Rapidos</p>
	</div>

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
				{#each top50 as entry (entry.rank)}
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
</div>

<style>
	.container {
		width: 100%;
		min-height: 100vh;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		padding: 2rem;
		margin-top: 1.5rem;
		display: flex;
		flex-direction: column;
		align-items: center;
	}

	.header {
		text-align: center;
		color: white;
		margin-bottom: 2rem;
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

	.player-highlight {
		width: 100%;
		max-width: 1000px;
		margin-bottom: 2rem;
		padding: 0.5rem 0;
		background: white;
		border-radius: 12px;
		box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
		border-left: 5px solid #667eea;
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
		color: #667eea;
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
		background: white;
		border-radius: 12px;
		box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
		overflow: hidden;
	}

	.leaderboard-table {
		width: 100%;
		border-collapse: collapse;
		font-size: 0.95rem;
	}

	.leaderboard-table thead {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		position: sticky;
		top: 0;
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
		background-color: #fff3cd;
		font-weight: 600;
	}

	.leaderboard-table tbody tr.highlighted:hover {
		background-color: #ffe69c;
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
		color: #667eea;
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
		color: #667eea;
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
		top: 1rem;
		left: 1.5rem;
		background: rgba(255, 255, 255, 0.2);
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 20px;
		font-size: 16px;
		cursor: pointer;
		backdrop-filter: blur(10px);
	}
</style>
