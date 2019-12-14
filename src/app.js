const express = require('express');
require('dotenv').config();
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.send('Database project');
});

app.listen(port, () => console.log('Our new server listening on ' + port));
