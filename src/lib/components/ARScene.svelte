<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState, type PlayerLocation, type Treasure } from '../stores/gameState.svelte';
	
	let arContainer = $state<HTMLDivElement>();
	let scene = $state<any>(null);
	let watchId = $state<number | null>(null);
	
	onMount(() => {
		initAR();
		startLocationTracking();
		
		return () => {
			cleanup();
		};
	});
	
	function initAR() {
		// Create AR.js scene with location-based AR
		const script = document.createElement('script');
		script.innerHTML = `
			// Initialize AR.js scene
			if (typeof THREEx !== 'undefined' && THREEx.LocationBased) {
				window.arScene = new THREEx.LocationBased(document.getElementById('arjs-scene'), {
					simulateLatitude: 0,
					simulateLongitude: 0
				});
				
				// Add camera
				const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
				
				// Add renderer
				const renderer = new THREE.WebGLRenderer({
					antialias: true,
					alpha: true
				});
				renderer.setSize(window.innerWidth, window.innerHeight);
				document.getElementById('arjs-scene').appendChild(renderer.domElement);
				
				// Add device orientation controls
				const controls = new THREEx.DeviceOrientationControls(camera);
				
				// Animation loop
				function animate() {
					requestAnimationFrame(animate);
					controls.update();
					renderer.render(window.arScene.scene, camera);
				}
				animate();
			}
		`;
		document.body.appendChild(script);
	}
	
	function startLocationTracking() {
		if ('geolocation' in navigator) {
			watchId = navigator.geolocation.watchPosition(
				(position) => {
					const location: PlayerLocation = {
						lat: position.coords.latitude,
						lng: position.coords.longitude
					};
					gameState.updateLocation(location);
					updateARObjects(location);
				},
				(error) => {
					console.error('Location error:', error);
				},
				{
					enableHighAccuracy: true,
					maximumAge: 0,
					timeout: 5000
				}
			);
		}
	}
	
	function updateARObjects(location: PlayerLocation) {
		// Generate nearby treasures based on current location
		const treasures = generateNearbyTreasures(location);
		gameState.updateNearbyTreasures(treasures);
	}
	
	function generateNearbyTreasures(location: PlayerLocation): Treasure[] {
		// Generate random treasures within 500 meters
		const treasures: Treasure[] = [];
		const numTreasures = 5;
		
		for (let i = 0; i < numTreasures; i++) {
			const angle = (Math.PI * 2 * i) / numTreasures;
			const distance = Math.random() * 200 + 50; // 50-250 meters
			
			const lat = location.lat + (distance * Math.cos(angle)) / 111111;
			const lng = location.lng + (distance * Math.sin(angle)) / (111111 * Math.cos(location.lat * Math.PI / 180));
			
			treasures.push({
				id: `treasure_${i}_${Date.now()}`,
				lat: lat,
				lng: lng,
				type: (['gem', 'coin', 'chest'] as const)[Math.floor(Math.random() * 3)],
				value: Math.floor(Math.random() * 100) + 10,
				distance: distance
			});
		}
		
		return treasures;
	}
	
	function calculateDistance(from: PlayerLocation, to: PlayerLocation) {
		const lat1 = from.lat * Math.PI / 180;
		const lon1 = from.lng * Math.PI / 180;
		const lat2 = to.lat * Math.PI / 180;
		const lon2 = to.lng * Math.PI / 180;
		
		const dLat = lat2 - lat1;
		const dLon = lon2 - lon1;
		
		const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
			Math.cos(lat1) * Math.cos(lat2) *
			Math.sin(dLon / 2) * Math.sin(dLon / 2);
		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		const distance = 6371 * c * 1000; // in meters
		
		return distance;
	}
	
	function cleanup() {
		if (watchId) {
			navigator.geolocation.clearWatch(watchId);
		}
	}
	
	onDestroy(() => {
		cleanup();
	});
</script>

<div class="ar-container" bind:this={arContainer}>
	<div id="arjs-scene" class="ar-scene"></div>
	<video id="arjs-video" autoplay playsinline></video>
</div>

<style>
	.ar-container {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		overflow: hidden;
	}
	
	.ar-scene {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
	
	#arjs-video {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		object-fit: cover;
		z-index: -1;
	}
</style>
