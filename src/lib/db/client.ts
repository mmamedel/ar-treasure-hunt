import type { SessionTreasure } from '$lib/stores/gameSessionPersisted';

export async function createDBSession(
	playerName: string,
	startTime: number,
	treasures: SessionTreasure[]
) {
	// Create Session in DB via API (server-side)

	const response = await fetch('/api/game-session', {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({
			playerName: playerName,
			startTime,
			treasures,
			isFinished: false
		})
	});

	if (!response.ok) {
		const error = await response.json();
		console.error('Failed to create game session:', error);
	}
}

export async function updateDBTreasure(playerName: string, treasure: SessionTreasure) {
	const response = await fetch('/api/treasure/update', {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({
			playerName: playerName,
			treasureId: treasure.id,
			start: treasure.start,
			end: treasure.end
		})
	});

	if (!response.ok) {
		const error = await response.json();
		console.error('Failed to update treasure in DB:', error);
	} else {
		const result = await response.json();
		console.log('Treasure updated successfully:', result);
	}
}

export async function setDBGameSessionFinished(
	playerName: string,
	gameStart: number,
	gameEnd: number,
	treasures: SessionTreasure[]
) {
	// Call API to update game session as completed
	const response = await fetch('/api/game-session/complete', {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({
			playerName: playerName,
			treasures: treasures,
			startTime: gameStart,
			endTime: gameEnd
		})
	});

	if (!response.ok) {
		const error = await response.json();
		console.error('Failed to complete game session:', error);
	} else {
		const result = await response.json();
		console.log('Game session completed successfully:', result);
	}
}
