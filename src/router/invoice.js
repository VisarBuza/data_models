const express = require('express');
const auth = require('../middleware/auth');
const router = new express.Router();
const Invoice = require('../models/invoice');

router.get('/invoices', auth, async (req, res) => {
    try {
        let invoices = await Invoice.getByUser(req.user.ID);

        if (!invoices.length > 0) {
            return res.status(404).send();
        }

        return res.send(invoices);
    } catch (e) {
        res.status(500).send();
    }
});

router.get('/invoices/:id', auth, async (req, res) => {
    try {
        let invoice = await Invoice.getById(req.params.id);

        if (!invoice.length > 0) {
            return res.status(404).send();
        }

        return res.send(invoice);
    } catch (e) {
        res.status(500).send();
    }
});

router.delete('/invoices/:id', auth, async (req, res) => {
    try {
        let invoice = await Invoice.delete(req.params.id);

        res.send(invoice);
    } catch (e) {
        return res.status(500).send();
    }
});

module.exports = router;
