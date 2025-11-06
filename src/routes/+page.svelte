<script lang="ts">
	import { goto } from '$app/navigation';

	const { users } = $props();

	setTimeout(() => {
		console.log(users);
	}, 5000);
	// goto('/name-entry');
</script>
