let db = require('../db/oracle');

let Cart = {};

Cart.getByUser = async id => {
    let connection = await db.getConnection();

    let cartItems = await connection.execute(
        `SELECT product_items
         FROM cart
         WHERE client_id = :id `,
        [id]
    );

    let bindParam = '';

    for (let i = 0; i < cartItems.rows[0].PRODUCT_ITEMS.length; i++) {
        if (i == cartItems.rows[0].PRODUCT_ITEMS.length - 1) {
            bindParam += ':var' + i;
        } else {
            bindParam += ':var' + i + ',';
        }
    }

    let items = await connection.execute(
        `SELECT *
         FROM variants
         where variants.id in (${bindParam})`,
        [...cartItems.rows[0].PRODUCT_ITEMS]
    );

    return items.rows;
};

Cart.add = async variantId => {
    let connection = db.getConnection();

    let items = await connection.execute(`INSERT`);
};

module.exports = Cart;
