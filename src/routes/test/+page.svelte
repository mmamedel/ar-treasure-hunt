<script lang="ts">
	import { onMount } from 'svelte';

	let hiroVisible = $state(true);
	let kanjiVisible = $state(false);

	onMount(() => {
		// Register click component
		//@ts-ignore
		AFRAME.registerComponent('boxclicker', {
			init: function () {
				this.el.addEventListener('click', () => {
					console.log('Box clicked!');
					// Toggle markers on click
					hiroVisible = !hiroVisible;
					kanjiVisible = !kanjiVisible;
				});
			}
		});
	});
</script>

<a-scene
	embedded
	cursor="rayOrigin: mouse"
	raycaster="near: 0; far: 50000"
	vr-mode-ui="enabled: false;"
	arjs="debugUIEnabled: false; detectionMode: mono_and_matrix; matrixCodeType: 3x3;"
>
	<a-marker type="pattern" url="data/kanji.patt">
		{#if kanjiVisible}
			<a-box position="0 0.5 0" material="color: red;" boxclicker> </a-box>
		{/if}
	</a-marker>

	<a-marker type="barcode" value="2">
		{#if hiroVisible}
			<a-box position="0 0.5 0" material="color: yellow;" boxclicker> </a-box>
		{/if}
	</a-marker>
	<a-entity camera></a-entity>
</a-scene>
