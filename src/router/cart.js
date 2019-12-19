const express = require('express');
const auth = require('../middleware/auth');
const router = new express.Router();
const Cart = require('../models/cart');

router.get('/cart', auth, async (req, res) => {
    try {
        let cartItems = await Cart.getByUser(req.user.ID);

        res.send(cartItems);
    } catch (e) {
        res.status(500).send();
    }
});

router.post('/cart', auth, async (req, res) => {
    try {
    } catch (e) {
        res.status(500).send();
    }
});

router.delete('/cart/:id', auth, async (req, res) => {
    try {
    } catch (e) {
        res.status(500).send();
    }
});

module.exports = router;
