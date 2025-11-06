<script lang="ts">
	import { goto } from '$app/navigation';

	const { data } = $props();

	console.log(data.gameSessions);
	// goto('/name-entry');
</script>
