const express = require('express');
const Product = require('../models/product');
const auth = require('../middleware/auth');
const router = new express.Router();

router.get('/products', auth, async (req, res) => {
    try {
        let products = await Product.getAllProducts();

        if (!products.length > 0) {
            return res.status(404).send();
        }

        res.send(products);
    } catch (e) {
        res.status(500).send();
    }
});

router.get('/products/:id', auth, async (req, res) => {
    try {
        let product = await Product.getWithOptions(req.params.id);

        if (!product) {
            return res.status(404).send();
        }

        res.send(product);
    } catch (e) {
        res.status(500).send();
    }
});

router.post('/products/:id/buy', auth, async (req, res) => {});

module.exports = router;
