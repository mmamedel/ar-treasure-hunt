<script lang="ts">
	import { gameState } from '$lib/stores/gameState';
	
	$: currentTreasure = $gameState.treasures[$gameState.currentTreasureIndex];
	$: treasureNumber = $gameState.currentTreasureIndex + 1;
	$: totalTreasures = $gameState.treasures.length;
	
	function handleOpenCamera() {
		gameState.navigateToScreen('ar-camera');
	}
</script>

<div class="screen-container">
	<div class="header">
		<div class="progress">Pista {treasureNumber} de {totalTreasures}</div>
		<div class="timer">⏱️ {$gameState.totalTime}</div>
	</div>
	
	<div class="container">
		<div class="clue-card">
			<div class="clue-number">Pista #{treasureNumber}</div>
			<div class="clue-icon">{currentTreasure.emoji}</div>
			<div class="clue-text">
				{currentTreasure.clue}
			</div>
		</div>
		
		<button class="camera-button" on:click={handleOpenCamera}>
			<span class="camera-icon">📷</span>
			<span>Abrir Câmera</span>
		</button>
		
		<div class="instructions">
			<p>Encontre o local indicado pela pista</p>
			<p>Procure pelo marcador AR no local</p>
		</div>
		
		<div class="progress-bar">
			<div 
				class="progress-fill" 
				style="width: {(treasureNumber - 1) / totalTreasures * 100}%"
			></div>
		</div>
		
		<p class="treasures-found">
			{$gameState.treasures.filter(t => t.found).length} tesouros encontrados
		</p>
	</div>
</div>

<style>
	.screen-container {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		padding: 20px;
	}
	
	.header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 30px;
	}
	
	.progress {
		font-size: 14px;
		opacity: 0.9;
	}
	
	.timer {
		font-size: 16px;
		font-weight: 600;
		background: rgba(0, 0, 0, 0.2);
		padding: 8px 15px;
		border-radius: 20px;
	}
	
	.container {
		flex: 1;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		max-width: 600px;
		margin: 0 auto;
		width: 100%;
	}
	
	.clue-card {
		background: rgba(255, 255, 255, 0.95);
		color: #333;
		padding: 30px;
		border-radius: 20px;
		width: 100%;
		margin-bottom: 30px;
		box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
	}
	
	.clue-number {
		background: linear-gradient(135deg, #667eea, #764ba2);
		color: white;
		display: inline-block;
		padding: 8px 20px;
		border-radius: 20px;
		font-weight: 600;
		margin-bottom: 20px;
		font-size: 14px;
	}
	
	.clue-icon {
		font-size: 64px;
		margin-bottom: 20px;
		text-align: center;
	}
	
	.clue-text {
		font-size: 20px;
		line-height: 1.6;
		text-align: center;
		color: #333;
		font-weight: 500;
	}
	
	.camera-button {
		background: #4CAF50;
		color: white;
		border: none;
		padding: 15px 40px;
		border-radius: 30px;
		font-size: 18px;
		font-weight: 600;
		cursor: pointer;
		transition: transform 0.2s;
		display: flex;
		align-items: center;
		gap: 10px;
		margin-bottom: 30px;
	}
	
	.camera-button:hover {
		transform: scale(1.05);
		box-shadow: 0 5px 20px rgba(76, 175, 80, 0.4);
	}
	
	.camera-icon {
		font-size: 24px;
	}
	
	.instructions {
		text-align: center;
		margin-bottom: 30px;
		opacity: 0.8;
	}
	
	.instructions p {
		margin: 5px 0;
		font-size: 14px;
	}
	
	.progress-bar {
		width: 100%;
		max-width: 300px;
		height: 8px;
		background: rgba(255, 255, 255, 0.3);
		border-radius: 4px;
		overflow: hidden;
		margin-bottom: 10px;
	}
	
	.progress-fill {
		height: 100%;
		background: #4CAF50;
		transition: width 0.5s ease;
	}
	
	.treasures-found {
		font-size: 14px;
		opacity: 0.9;
		text-align: center;
	}
</style>
