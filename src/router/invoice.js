const express = require('express');
const auth = require('../middleware/auth');
const router = new express.Router();

router.get('/invoices', auth, (req, res) => {
    res.send(req.body);
});

router.get('/invoices/:id', auth, (req, res) => {
    res.send(req.body);
});

router.delete('/invoices/:id', auth, (req, res) => {
    res.send(req.body);
});

module.exports = router;
