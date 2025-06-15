/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Post";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "MediaFile" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "fileUrl" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "mediaVideoId" INTEGER,
    "mediaVideoThumbnailId" INTEGER,
    "mediaImageId" INTEGER,
    "mediaAlbumId" INTEGER,
    CONSTRAINT "MediaFile_mediaVideoId_fkey" FOREIGN KEY ("mediaVideoId") REFERENCES "MediaVideo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MediaFile_mediaVideoThumbnailId_fkey" FOREIGN KEY ("mediaVideoThumbnailId") REFERENCES "MediaVideo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MediaFile_mediaImageId_fkey" FOREIGN KEY ("mediaImageId") REFERENCES "MediaImage" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "MediaFile_mediaAlbumId_fkey" FOREIGN KEY ("mediaAlbumId") REFERENCES "MediaAlbum" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MediaVideo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "source" TEXT NOT NULL DEFAULT 'CUSTOM',
    "sourceUrl" TEXT,
    "title" TEXT,
    "author" TEXT,
    "caption" TEXT
);

-- CreateTable
CREATE TABLE "MediaImage" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "source" TEXT NOT NULL DEFAULT 'CUSTOM',
    "sourceUrl" TEXT,
    "title" TEXT,
    "author" TEXT,
    "caption" TEXT
);

-- CreateTable
CREATE TABLE "MediaAlbum" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "source" TEXT NOT NULL DEFAULT 'CUSTOM',
    "sourceUrl" TEXT,
    "title" TEXT,
    "author" TEXT,
    "caption" TEXT
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "role" TEXT NOT NULL DEFAULT 'USER'
);
INSERT INTO "new_User" ("email", "id", "name") SELECT "email", "id", "name" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "MediaFile_mediaVideoId_key" ON "MediaFile"("mediaVideoId");

-- CreateIndex
CREATE UNIQUE INDEX "MediaFile_mediaVideoThumbnailId_key" ON "MediaFile"("mediaVideoThumbnailId");

-- CreateIndex
CREATE UNIQUE INDEX "MediaFile_mediaImageId_key" ON "MediaFile"("mediaImageId");

-- CreateIndex
CREATE UNIQUE INDEX "MediaFile_mediaAlbumId_key" ON "MediaFile"("mediaAlbumId");

-- CreateIndex
CREATE UNIQUE INDEX "MediaVideo_sourceUrl_key" ON "MediaVideo"("sourceUrl");

-- CreateIndex
CREATE UNIQUE INDEX "MediaImage_sourceUrl_key" ON "MediaImage"("sourceUrl");

-- CreateIndex
CREATE UNIQUE INDEX "MediaAlbum_sourceUrl_key" ON "MediaAlbum"("sourceUrl");
