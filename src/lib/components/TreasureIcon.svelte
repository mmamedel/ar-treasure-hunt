<script lang="ts">
	interface Props {
		treasureId: number;
	}

	let { treasureId }: Props = $props();

	const iconMap: Record<number, string> = {
		0: '/images/emojis/musical-notes.svg',
		1: '/images/emojis/classical-building.svg',
		2: '/images/emojis/amphora.svg',
		3: '/images/emojis/eye.svg',
		4: '/images/emojis/droplet.svg',
		5: '/images/emojis/scroll.svg'
	};

	const iconSrc = $derived(iconMap[treasureId] || '');
</script>

<img src={iconSrc} alt="" class="treasure-icon" />

<style>
	.treasure-icon {
		width: 70%;
		height: 70%;
		object-fit: contain;
		filter: brightness(0) saturate(100%) invert(18%) sepia(13%) saturate(959%) hue-rotate(349deg)
			brightness(95%) contrast(93%);
	}
</style>
