const express = require('express');
const auth = require('../middleware/auth');
const router = new express.Router();

router.get('/cart', auth, (req, res) => {
    res.send(req.body);
});

router.post('/cart', auth, (req, res) => {
    res.send(req.user);
});

router.delete('/cart/:id', auth, (req, res) => {
    res.send(req.body);
});

module.exports = router;
