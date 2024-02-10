const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.https.onCall((data, context) => {
    const token = data.token;
    const message = {
        notification: {
            title: data.title,
            body: data.body
        },
        token: token,
    }

    return admin.messaging().send(message)
        .then((response) => {
            return console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            return console.log('Error sending message:', error);
        });
});