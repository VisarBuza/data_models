const db = require('../db/oracle');

let Invoice = {};

Invoice.selectAndRank = async id => {
    let connection = await db.getConnection();
};

module.exports = Invoice;