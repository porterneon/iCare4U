const { admin, db } = require('../util/admin');
const firebase = require('firebase');
const config = require('../util/config');

firebase.initializeApp(config);

const {
    validateSignupData,
    validateLoginData,
    reduceUserDetails
} = require('../util/validators');

exports.getAllUsers = async (req, res) => {
    try {
        const data = await db.collection('users').get();

        let items = [];
        data.docs.forEach(doc => {
            items.push(doc.data());
        });

        return res.status(200).json(items);
    }
    catch (err) 
    {
        return res.status(500).json(e);
    }
};