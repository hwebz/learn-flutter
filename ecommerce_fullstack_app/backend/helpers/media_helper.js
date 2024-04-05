const multer = require('multer');
const path = require('path');
const { unlink } = require('fs').promises;

const ALLOWED_EXTENSIONS = {
  'image/png': 'png',
  'image/jpg': 'jpg',
  'image/jpeg': 'jpeg',
};

const storage = multer.diskStorage({
  destination: (_, __, cb) => {
    return cb(null, 'public/uploads');
  },
  filename: (_, file, cb) => {
    const filename = file.originalname
      .replace(' ', '-')
      .replace('.png', '')
      .replace('.jpg', '')
      .replace('.jpeg', '');
    const extension = ALLOWED_EXTENSIONS[file.mimetype];
    cb(null, `${filename}-${Date.now()}.${extension}`);
  },
})

exports.upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5. // 5MB
  },
  fileFilter: (_, file, cb) => {
    const isValidImageFile = ALLOWED_EXTENSIONS[file.mimetype];
    const uploadError = new Error(`Invalid image type\n${file.mimetype} is not allowed.`)
    if (!isValidImageFile) {
      return cb(uploadError);
    }

    return cb(null, true);
  }
});

exports.deleteImages = async (imageUrls, continueOnErrorName) => {
  await Promise.all(
    imageUrls.map(async imageUrl => {
      const imagePath = path.resolve(__dirname, '..', 'public', 'uploads', path.basename(imageUrl));
      try {
        await unlink(imagePath);
      } catch (error) {
        if (error.code === continueOnErrorName) {
          console.error(`Continuing with the next image: ${error.message}`);
        } else {
          console.error(`Error deleting image: ${error.message}`);
          throw error;
        }
      }
    })
  )
}