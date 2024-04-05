const express = require('express');
const router = express.Router();

const adminController = require('../controllers/admin');

// USERS
router.get('/users/count', adminController.getUsersCount);
router.delete('/users/:id', adminController.deleteUser);

// CATEGORIES
router.post('/categories', adminController.addCategory);
router.put('/categories/:id', adminController.updateCategory);
router.delete('/categories/:id', adminController.deleteCategory);

// PRODUCTS
router.get('/products/count', adminController.getProductsCount);
router.post('/products', adminController.addProduct);
router.put('/products/:id', adminController.updateProduct);
router.delete('/products/:id', adminController.deleteProduct);


// ORDERS
router.get('/orders', adminController.getOrders);
router.get('/orders/count', adminController.getOrdersCount);
router.put('/orders/:id', adminController.changeOrderStatus);

module.exports = router;