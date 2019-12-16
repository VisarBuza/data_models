const express = require('express');
const User = require('../models/user');
const jwt = require('jsonwebtoken');
const router = new express.Router();

router.post('/register', async (req, res) => {
    try {
        let user = await User.createUser(req.body);

        if (user) {
            res.status(201).send(user);
        }
    } catch (e) {
        res.status(500).send(e);
    }
});

router.post('/login', async (req, res) => {
    try {
        let user = await User.findByCredentials(req.body.email, req.body.password);

        let token = await jwt.sign(
            {
                id: user.ID,
                email: user.EMAIL
            },
            process.env.SECRET_KEY,
            { expiresIn: '1h' }
        );

        user.token = token;

        res.send(user);
    } catch (e) {
        res.status(500).send(e);
    }
});

module.exports = router;
