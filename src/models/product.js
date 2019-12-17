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

Product.getWithOptions = async id => {
    let connection = await db.getConnection();

    let product = await connection.execute(
        `SELECT products.id, products.name as productName, products.description, products.brand, products.price, products.stock, options.name as optionName 
         FROM products, options WHERE products.id = options.product_id and products.id = :id`,
        [id]
    );

    return product.rows;
};

module.exports = Product;
