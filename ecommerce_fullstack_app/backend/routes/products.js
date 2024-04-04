const express = require('express');
const productsController = require('../controllers/products');

const router = express.Router();

router.get('/:id', productsController.getProductDetails);
router.post('/:id', productsController.addProduct);
router.put('/:id', productsController.updateProduct);
router.delete('/:id', productsController.deleteProduct);

module.exports = router;