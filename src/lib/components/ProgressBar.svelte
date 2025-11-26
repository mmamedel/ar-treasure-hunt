<script lang="ts">
	interface Props {
		current: number; // Current treasure index (0-5)
		total: number; // Total treasures (6)
	}

	let { current = 0, total = 6 }: Props = $props();
</script>

<div class="progress-container">
	<div class="progress-bar">
		{#each Array(total) as _, index}
			<div
				class="segment"
				class:filled={index < current}
				class:first={index === 0}
				class:last={index === total - 1}
			></div>
		{/each}
	</div>
	<p class="progress-label">Tesouros encontrados</p>
</div>

<style>
	.progress-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 6px;
		margin: 1rem 0;
	}

	.progress-bar {
		display: flex;
		gap: 0;
		height: 15px;
	}

	.segment {
		width: 44px;
		height: 15px;
		background: transparent;
		border: var(--border-width) solid var(--color-border);
		border-left: none;
		box-sizing: border-box;
	}

	.segment:first-child {
		border-left: var(--border-width) solid var(--color-border);
	}

	.segment.first {
		border-radius: 13px 0 0 13px;
	}

	.segment.last {
		border-radius: 0 13px 13px 0;
	}

	.segment.filled {
		background: var(--color-accent);
	}

	.progress-label {
		font-family: var(--font-primary);
		font-size: 21px;
		color: var(--color-primary);
		margin: 0;
		text-align: center;
	}
</style>
