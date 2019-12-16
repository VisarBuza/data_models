const express = require('express');
const Product = require('../models/product');
const auth = require('../middleware/auth');
const router = new express.Router();

module.exports = router;
