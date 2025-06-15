import { join } from 'pathe'
import { mkdir, rename } from 'fs/promises'
import formidable from 'formidable'

export default defineEventHandler(async (event) =>
{
    // get upload path
    const config = useRuntimeConfig(event)
    const uploadsBasePath = config.uploadsBasePath || '/uploads'
    const uploadsTempPath = join(uploadsBasePath, 'temp')

    var finalFilePaths : string[] = [];

    // formidable expects a Node.js IncomingMessage
    const nodeReq = event.node.req

    // Create the formidable form with temp upload directory
    const form = formidable({
        multiples: true,
        uploadDir: uploadsTempPath,
        keepExtensions: true,
        maxFileSize: 100 * 1024 * 1024, // 100 MB
    });

    // Parse the incoming form data
    form.parse(nodeReq, async (err, fields, files) => {
        if (err) {
            throw createError({
                statusCode: 400,
                statusMessage: 'File upload failed',
                data: err,
            });
        }

        // check fields
        const id = fields.id as unknown as string;
        const type = fields.type as unknown as string;

        // create upload path
        const uploadPath = join(uploadsBasePath, type, id);

        try {
            // Ensure the upload directory exists
            await mkdir(uploadPath, { recursive: true });

            // Move each uploaded file to the final destination
            const fileKeys = Object.keys(files);
            var fileCounter = 0;
            for (const key of fileKeys) {
                const fileEntry = files[key]!;
                const fileArray = Array.isArray(fileEntry) ? fileEntry : [fileEntry];
                for (const file of fileArray) {
                    const newFilePath = join(uploadPath, type, fileCounter > 0 ? "-" + fileCounter.toString() : '');
                    await rename(file.filepath, newFilePath);
                    finalFilePaths.push(newFilePath);
                }
            }


            return { success: true, message: 'Files uploaded successfully' };
        } catch (error) {
            throw createError({
                statusCode: 500,
                statusMessage: 'Failed to move uploaded files',
                data: error,
            });
        }

    });

});
