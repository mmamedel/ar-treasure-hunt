<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState, type PlayerLocation, type Treasure } from '../stores/gameState.svelte';
	
	let arContainer = $state<HTMLDivElement>();
	let scene = $state<any>(null);
	let watchId = $state<number | null>(null);
	let fixedTreasures: Treasure[] = [];
	let visibleTreasures = $state<Treasure[]>([]);
	
	onMount(() => {
		initCamera();
		initAR();
		initializeFixedTreasures();
		startLocationTracking();
		
		return () => {
			cleanup();
		};
	});
	
	async function initCamera() {
		try {
			// Get the camera stream
			const stream = await navigator.mediaDevices.getUserMedia({ 
				video: { 
					facingMode: 'environment',
					width: { ideal: 1920 },
					height: { ideal: 1080 }
				},
				audio: false
			});
			
			// Connect stream to video element
			const video = document.getElementById('arjs-video') as HTMLVideoElement;
			if (video) {
				video.srcObject = stream;
				video.play();
			}
		} catch (error) {
			console.error('Camera initialization error:', error);
		}
	}
	
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
	
	function initializeFixedTreasures() {
		// Get current location first to generate treasures around it
		navigator.geolocation.getCurrentPosition((position) => {
			const currentLat = position.coords.latitude;
			const currentLng = position.coords.longitude;
			
			// Generate fixed treasures within 20 meters of starting position
			fixedTreasures = [
				{
					id: 'treasure_1',
					lat: currentLat + 0.00002, // ~2.2 meters north
					lng: currentLng,
					type: 'gem',
					value: 100,
					distance: 0
				},
				{
					id: 'treasure_2',
					lat: currentLat,
					lng: currentLng + 0.00003, // ~3.3 meters east
					type: 'coin',
					value: 50,
					distance: 0
				},
				{
					id: 'treasure_3',
					lat: currentLat - 0.00005, // ~5.5 meters south
					lng: currentLng - 0.00002,
					type: 'chest',
					value: 200,
					distance: 0
				},
				{
					id: 'treasure_4',
					lat: currentLat + 0.00008, // ~8.8 meters north
					lng: currentLng + 0.00005,
					type: 'gem',
					value: 150,
					distance: 0
				}
			];
		});
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
					updateVisibleTreasures(location);
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
	
	function updateVisibleTreasures(location: PlayerLocation) {
		// Only show treasures within 2 meters
		const VISIBILITY_DISTANCE = 2; // meters
		
		visibleTreasures = fixedTreasures.filter(treasure => {
			const distance = calculateDistance(location, { lat: treasure.lat, lng: treasure.lng });
			treasure.distance = distance;
			return distance <= VISIBILITY_DISTANCE;
		});
		
		// Update game state with visible treasures
		gameState.updateNearbyTreasures(visibleTreasures);
		
		// Update AR display
		updateARDisplay();
	}
	
	function updateARDisplay() {
		// Clear existing AR objects
		const arScene = document.getElementById('arjs-scene');
		if (!arScene) return;
		
		// Remove old treasure elements
		const oldTreasures = arScene.querySelectorAll('.ar-treasure');
		oldTreasures.forEach(el => el.remove());
		
		// Add visible treasures to AR scene
		visibleTreasures.forEach(treasure => {
			const treasureEl = document.createElement('div');
			treasureEl.className = 'ar-treasure';
			treasureEl.dataset.id = treasure.id;
			treasureEl.innerHTML = `
				<div class="treasure-icon">${treasure.type === 'gem' ? '💎' : treasure.type === 'coin' ? '🪙' : '📦'}</div>
				<div class="treasure-value">${treasure.value}</div>
			`;
			arScene.appendChild(treasureEl);
		});
	}
	
	function calculateDistance(from: PlayerLocation, to: PlayerLocation): number {
		const R = 6371000; // Earth's radius in meters
		const lat1 = from.lat * Math.PI / 180;
		const lon1 = from.lng * Math.PI / 180;
		const lat2 = to.lat * Math.PI / 180;
		const lon2 = to.lng * Math.PI / 180;
		
		const dLat = lat2 - lat1;
		const dLon = lon2 - lon1;
		
		const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
				  Math.cos(lat1) * Math.cos(lat2) *
				  Math.sin(dLon/2) * Math.sin(dLon/2);
		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
		
		return R * c; // Distance in meters
	}
	
	function cleanup() {
		if (watchId) {
			navigator.geolocation.clearWatch(watchId);
		}
		
		// Stop camera stream
		const video = document.getElementById('arjs-video') as HTMLVideoElement;
		if (video && video.srcObject) {
			const stream = video.srcObject as MediaStream;
			stream.getTracks().forEach(track => track.stop());
			video.srcObject = null;
		}
	}
	
	onDestroy(() => {
		cleanup();
	});
</script>

<div class="ar-container" bind:this={arContainer}>
	<div id="arjs-scene" class="ar-scene"></div>
	<video id="arjs-video" autoplay playsinline muted>
		<track kind="captions" src="" default />
	</video>
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
	
	:global(.ar-treasure) {
		position: absolute;
		transform: translate(-50%, -50%);
		text-align: center;
		animation: float 2s ease-in-out infinite;
		z-index: 100;
	}
	
	:global(.treasure-icon) {
		font-size: 3rem;
		filter: drop-shadow(0 4px 6px rgba(0,0,0,0.5));
		animation: pulse 1.5s ease-in-out infinite;
	}
	
	:global(.treasure-value) {
		color: white;
		font-weight: bold;
		font-size: 1.2rem;
		text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
		margin-top: 0.5rem;
		background: rgba(0,0,0,0.5);
		padding: 0.25rem 0.5rem;
		border-radius: 10px;
	}
	
	@keyframes float {
		0%, 100% { transform: translate(-50%, -50%) translateY(0); }
		50% { transform: translate(-50%, -50%) translateY(-10px); }
	}
	
	@keyframes pulse {
		0%, 100% { transform: scale(1); }
		50% { transform: scale(1.1); }
	}
</style>
