const { Category } = require('../../models/category');
const mediaHelper = require('../../helpers/media_helper');
const util = require('util');

exports.addCategory = async (req, res) => {
  try {
    const imageUpload = util.promisify(mediaHelper.upload.fields([
      { name: 'image', maxCount: 1 },
    ]));
    try {
      await imageUpload(req, res);
    } catch (error) {
      return res.status(500).json({
        type: error.code,
        message: `${error.message}{${error.field}}`,
        storageErrors: error.storageErrors
      });
    }

    const image = req.files['image'][0];
    if (!image) return res.status(404).json({ message: 'No file found!' });

    req.body['image'] = `${req.protocol}://${req.get('host')}/${image.path}`;
    let category = new Category(req.body);

    category = category.save();
    if (!category) {
      return res.status(500).json({ message: 'The category could not be created!' });
    }

    return res.status(201).json(category);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.updateCategory = async (req, res) => {
  try {
    const { name, icon, colour } = req.body;
    const category = await Category.findByIdAndUpdate(req.params.id, {
      name,
      icon,
      colour,
    }, {
      new: true,
    });
    if (!category) {
      return res.status(404).json({ message: 'Category not found!' });
    }
    return res.json(category);
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};

exports.deleteCategory = async (req, res) => {
  try {
    const category = await Category.findById(req.params.id);
    if (!category) {
      return res.status(404).json({ message: 'Category not found!' });
    }

    category.markedForDeletion = true;
    await category.save();

    return res.status(204).end();
  } catch (error) {
    return res.status(500).json({ type: error.name, message: error.message });
  }
};