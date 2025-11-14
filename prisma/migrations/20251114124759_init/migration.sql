-- CreateTable
CREATE TABLE "GameSession" (
    "id" SERIAL NOT NULL,
    "playerName" TEXT NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3),
    "currentTreasureIndex" INTEGER NOT NULL,
    "hasReceivedPrize" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "GameSession_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Treasure" (
    "id" SERIAL NOT NULL,
    "gameSessionId" INTEGER NOT NULL,
    "treasureNumber" INTEGER NOT NULL,
    "start" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "end" TIMESTAMP(3),
    "found" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Treasure_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "GameSession_playerName_key" ON "GameSession"("playerName");

-- AddForeignKey
ALTER TABLE "Treasure" ADD CONSTRAINT "Treasure_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES "GameSession"("id") ON DELETE CASCADE ON UPDATE CASCADE;
