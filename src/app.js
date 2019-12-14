const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Database project');
});

app.listen(port, () => console.log('Our new server listening on ' + port));
