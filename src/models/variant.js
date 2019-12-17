const db = require('../db/oracle');
const Product = require('./product');

let Variant = {};

Variant.getByProduct = async id => {
    let connection = db.getConnection();

    let variant = await connection.execute(`SELECT * FROM variants WHERE product_id = :id`, [id]);

    return variant.rows;
};

module.exports = Variant;
