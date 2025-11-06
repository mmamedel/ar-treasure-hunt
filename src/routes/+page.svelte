<script lang="ts">
	import { goto } from '$app/navigation';
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();

	setTimeout(() => {
		console.log(data.users);
	}, 5000);
	// goto('/name-entry');
</script>
