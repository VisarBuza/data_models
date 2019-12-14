const oracledb = require('oracledb');
require('dotenv').config();

oracledb.autoCommit = true;
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function run() {
    let connection;

    try {
        connection = await oracledb.getConnection({
            user: process.env.ORACLE_USER,
            password: process.env.ORACLE_PASS,
            connectString: process.env.ORACLE_URI
        });

        const result = await connection.execute(
            `SELECT *
            FROM users`
        );
        console.log(result.rows);
    } catch (err) {
        console.error(err);
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}

run();

// let oracle = {};

// const connectionProperties = {
//     user: process.env.ORACLE_USER,
//     password: process.env.ORACLE_PASS,
//     connectString: process.env.ORACLE_URI
// };

// oracle.getConnect = () =>
//     new Promise((resolve, reject) => {
//         oracledb.getConnection(connectionProperties, (err, connection) => {
//             if (connection) {
//                 resolve(connection);
//             } else {
//                 reject(err);
//             }
//         });
//     });

// oracle.doRelease = connection => {
//     return connection.close(err => {
//         if (err) {
//             console.error(err.message);
//         }
//     });
// };

// oracle.executeAsync = (sql, bindParams, connection) => {
//     return new Promise((resolve, reject) => {
//         connection.execute(sql, bindParams, (err, result) => {
//             if (err) {
//                 console.error(err.message);
//                 reject(err);
//             }
//             resolve(result.rows);
//         });
//     });
// };

// module.exports = oracle;
