import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
  const id = event.context.params?.id;
  if (!id) {
    throw createError({
      statusCode: 400,
      statusMessage: 'ID parameter is required',
    });
  }

  const video = await prisma.mediaVideo.findUnique({
    where: { id: parseInt(id, 10) },
    include: {
      file: true,
      thumbnailFile: true,
    },
  });

  if (!video) {
    throw createError({
      statusCode: 404,
      statusMessage: 'Video not found',
    });
  }

  return video;
});