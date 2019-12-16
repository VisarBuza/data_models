const db = require('../db/oracle');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('./user');

let Product = {};

Product.getAllProducts = async () => {
    let connection = await db.getConnection();

    let products = await connection.execute(`SELECT * FROM PRODUCTS`);

    return products.rows;
};

Product.getById = async id => {
    let connection = await db.getConnection();

    let product = await connection.execute(`SELECT * FROM PRODUCTS WHERE id = :id`, [id]);

    return product.rows[0];
};

module.exports = Product;
