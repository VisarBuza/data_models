const oracledb = require('oracledb');
require('dotenv').config();

oracledb.autoCommit = true;
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

let db = {};

db.getConnection = async () => {
    let connection;

    try {
        connection = await oracledb.getConnection({
            user: process.env.ORACLE_USER,
            password: process.env.ORACLE_PASS,
            connectString: process.env.ORACLE_URI
        });

        return connection;
    } catch (err) {
        throw new Error(err);
    }
};

module.exports = db;
