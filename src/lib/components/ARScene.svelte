<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { gameState, type PlayerLocation, type Treasure } from '../stores/gameState.svelte';
	
	let arContainer = $state<HTMLDivElement>();
	let scene = $state<any>(null);
	let watchId = $state<number | null>(null);
	let fixedTreasures: Treasure[] = [];
	let visibleTreasures = $state<Treasure[]>([]);
	let devMode = $state(false);
	
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
		// Initialize AR.js scene
		const script = document.createElement('script');
		script.textContent = `
			if (typeof THREEx !== 'undefined' && THREEx.LocationBased) {
				const scene = new THREE.Scene();
				const camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 0.01, 1000);
				const renderer = new THREE.WebGLRenderer({ 
					alpha: true,
					antialias: true
				});
				
				renderer.setSize(window.innerWidth, window.innerHeight);
				document.getElementById('arjs-scene').appendChild(renderer.domElement);
				
				const arjs = new THREEx.LocationBased(scene, camera);
				const cam = new THREEx.WebcamRenderer(renderer);
				
				// Store scene and AR.js instance globally for access
				window.arScene = {
					scene: scene,
					camera: camera,
					renderer: renderer,
					arjs: arjs
				};
				
				// Enable device orientation controls
				const controls = new THREEx.DeviceOrientationControls(camera);
				
				// Animation loop
				function animate() {
					requestAnimationFrame(animate);
					controls.update();
					renderer.render(scene, camera);
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
		// Only show treasures within 2 meters (unless in dev mode)
		const VISIBILITY_DISTANCE = 2; // meters
		
		if (devMode) {
			// In dev mode, show all treasures with distance info
			visibleTreasures = fixedTreasures.map(treasure => {
				const distance = calculateDistance(location, { lat: treasure.lat, lng: treasure.lng });
				return { ...treasure, distance };
			});
		} else {
			// Normal mode: only show treasures within visibility distance
			visibleTreasures = fixedTreasures.filter(treasure => {
				const distance = calculateDistance(location, { lat: treasure.lat, lng: treasure.lng });
				treasure.distance = distance;
				return distance <= VISIBILITY_DISTANCE;
			});
		}
		
		// Update game state with visible treasures
		gameState.updateNearbyTreasures(visibleTreasures);
		
		// Update AR display
		updateARDisplay();
	}
	
	function updateARDisplay() {
		// Wait for AR.js to be ready
		if (!window.arScene?.arjs) {
			setTimeout(() => updateARDisplay(), 100);
			return;
		}
		
		// Clear existing treasure meshes
		if (window.arTreasures) {
			window.arTreasures.forEach(mesh => {
				window.arScene.scene.remove(mesh);
			});
		}
		window.arTreasures = [];
		
		// Add visible treasures as 3D objects in AR scene
		visibleTreasures.forEach(treasure => {
			const isInRange = treasure.distance <= 2;
			
			// Create 3D object for treasure
			let geometry, material;
			
			if (treasure.type === 'gem') {
				// Diamond shape
				geometry = new THREE.OctahedronGeometry(1, 0);
				material = new THREE.MeshBasicMaterial({ 
					color: 0x00ffff,
					opacity: isInRange || devMode ? 1 : 0.5,
					transparent: true
				});
			} else if (treasure.type === 'coin') {
				// Coin shape
				geometry = new THREE.CylinderGeometry(1, 1, 0.2, 16);
				material = new THREE.MeshBasicMaterial({ 
					color: 0xffd700,
					opacity: isInRange || devMode ? 1 : 0.5,
					transparent: true
				});
			} else {
				// Chest shape
				geometry = new THREE.BoxGeometry(1.5, 1, 1);
				material = new THREE.MeshBasicMaterial({ 
					color: 0x8b4513,
					opacity: isInRange || devMode ? 1 : 0.5,
					transparent: true
				});
			}
			
			const mesh = new THREE.Mesh(geometry, material);
			mesh.userData = { treasureId: treasure.id, value: treasure.value };
			
			// Add treasure to AR scene at GPS location
			window.arScene.arjs.add(mesh, treasure.lng, treasure.lat);
			window.arTreasures.push(mesh);
			
			// Add floating animation
			const animateTreasure = () => {
				if (mesh.parent) {
					mesh.rotation.y += 0.02;
					mesh.position.y = Math.sin(Date.now() * 0.001) * 0.2;
					requestAnimationFrame(animateTreasure);
				}
			};
			animateTreasure();
		});
		
		// Update HUD with treasure info if in dev mode
		if (devMode) {
			updateDevHUD();
		}
	}
	
	function updateDevHUD() {
		let hudEl = document.getElementById('dev-hud');
		if (!hudEl) {
			hudEl = document.createElement('div');
			hudEl.id = 'dev-hud';
			hudEl.className = 'dev-hud';
			document.body.appendChild(hudEl);
		}
		
		hudEl.innerHTML = `
			<div class="hud-title">📍 Treasures</div>
			${visibleTreasures.map(t => `
				<div class="hud-item">
					${t.type === 'gem' ? '💎' : t.type === 'coin' ? '🪙' : '📦'} 
					${t.distance.toFixed(1)}m - ${t.value}pts
				</div>
			`).join('')}
		`;
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
	<video id="arjs-video" autoplay playsinline muted>
		<track kind="captions" />
	</video>
	<div id="arjs-scene"></div>
	
	<!-- Dev Mode Toggle -->
	<button 
		class="dev-mode-toggle"
		onclick={() => devMode = !devMode}
		type="button"
	>
		🛠️ Dev: {devMode ? 'ON' : 'OFF'}
	</button>
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
	
	:global(.dev-hud) {
		position: absolute;
		top: 70px;
		right: 20px;
		background: rgba(0, 0, 0, 0.8);
		color: white;
		padding: 1rem;
		border-radius: 10px;
		font-size: 0.9rem;
		max-width: 200px;
		z-index: 999;
	}
	
	:global(.hud-title) {
		font-weight: bold;
		margin-bottom: 0.5rem;
		border-bottom: 1px solid #FFD700;
		padding-bottom: 0.25rem;
	}
	
	:global(.hud-item) {
		margin: 0.25rem 0;
	}
	
	.dev-mode-toggle {
		position: absolute;
		top: 20px;
		right: 20px;
		padding: 0.5rem 1rem;
		background: rgba(0, 0, 0, 0.7);
		color: white;
		border: 2px solid #FFD700;
		border-radius: 10px;
		font-weight: bold;
		cursor: pointer;
		z-index: 1000;
		transition: all 0.3s ease;
	}
	
	.dev-mode-toggle:hover {
		background: rgba(255, 215, 0, 0.2);
		transform: scale(1.05);
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
