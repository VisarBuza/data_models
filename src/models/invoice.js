const db = require('../db/oracle');

let Invoice = {};

Invoice.getByUser = async id => {
    let connection = await db.getConnection();

    let invoices = await connection.execute(
        `SELECT invoices.invoice_id as invoiceId, invoices.total_amount as totalAmount, quantity, payment_type.name as paymentMethod, variants.description, variants.id as variantId, products.name as productName
         FROM invoices, invoice_details , payment_type, variants, products
         WHERE invoices.invoice_id = invoice_details.invoice_id and 
         invoices.payment_type_id = payment_type.id and  
         invoices.client_id = :id and 
         invoice_details.variant_id = variants.id and 
         variants.product_id = products.id`,
        [id]
    );

    return invoices.rows;
};

Invoice.getById = async id => {
    let connection = await db.getConnection();

    let invoice = await connection.execute(
        `SELECT invoices.invoice_id as invoiceId, invoices.total_amount as totalAmount, quantity, payment_type.name as paymentMethod, variants.description, variants.id as variantId, products.name as productName
         FROM invoices, invoice_details , payment_type, variants, products
         WHERE invoices.invoice_id = invoice_details.invoice_id and 
         invoices.payment_type_id = payment_type.id and  
         invoices.invoice_id = :id and 
         invoice_details.variant_id = variants.id and 
         variants.product_id = products.id`,
        [id]
    );

    return invoice.rows;
};

Invoice.delete = async id => {
    let connection = await db.getConnection();

    let invoice = await connection.execute(
        `DELETE
         FROM invoices
         WHERE invoice_id = :id`,
        [id]
    );

    console.log(invoice);

    return invoice.rowsAffected;
};

module.exports = Invoice;
