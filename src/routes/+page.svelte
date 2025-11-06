<script lang="ts">
	import { goto } from '$app/navigation';

	const { data } = $props();

	console.log(data.users);
	// goto('/name-entry');
</script>
