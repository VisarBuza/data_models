const express = require('express');
require('dotenv').config();
const userRouter = require('./router/user');
const productRouter = require('./router/product');
const invoiceRouter = require('./router/invoice');
const cartRouter = require('./router/cart');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(userRouter);
app.use(productRouter);
app.use(invoiceRouter);
app.use(cartRouter);

app.listen(port, () => console.log('Our new server listening on ' + port));
