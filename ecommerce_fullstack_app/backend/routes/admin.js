const express = require('express');
const router = express.Router();

const adminController = require('../controllers/admin');
const usersController = require('../controllers/admin/users');
const categoriesController = require('../controllers/admin/categories');

// USERS
router.get('/users/count', usersController.getUsersCount);
router.delete('/users/:id', usersController.deleteUser);

// CATEGORIES
router.post('/categories', categoriesController.addCategory);
router.put('/categories/:id', categoriesController.updateCategory);
router.delete('/categories/:id', categoriesController.deleteCategory);

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