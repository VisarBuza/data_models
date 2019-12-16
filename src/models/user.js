const db = require('../db/oracle');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Product = require('./product');

let User = {};

User.createUser = async ({ firstname, lastname, email, password, address, phoneNumbers }) => {
    const { street, city, zip } = address;

    const hashedPassword = bcrypt.hashSync(password, 10);

    let connection = await db.getConnection();

    let user = await connection.execute(
        `
        INSERT INTO users (name, email, password, address, phone_numbers, created_at, updated_at) VALUES
        (Name(:firstname, :lastname), 
        :email,
        :password,
        Address
        (:street,:city,:zip),
        PHONE_LIST(:phoneNumbers),
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP)`,
        [firstname, lastname, email, hashedPassword, street, city, zip, phoneNumbers[0]]
    );

    if (user.rowsAffected == 0) {
        throw new Error('Could not register');
    }

    return user.rowsAffected;
};

User.findById = async id => {
    let connection = await db.getConnection();

    let user = await connection.execute(`SELECT * FROM users WHERE id = :id`, [id]);

    return user.rows[0];
};

User.findByCredentials = async (email, password) => {
    let connection = await db.getConnection();

    let user = await connection.execute(`SELECT * FROM users WHERE email=:email`, [email]);

    if (!user) {
        throw new Error('Unable to login');
    }

    const isMatch = await bcrypt.compare(password, user.rows[0].PASSWORD);

    if (!isMatch) {
        throw new Error('Unable to login');
    }

    return user.rows[0];
};

module.exports = User;
