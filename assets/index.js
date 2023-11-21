const functions = require("firebase-functions");
const firebaseAdmin = require('firebase-admin');
const serviceAccount = './firebaseConfig.json';
const firebaseUrl = 'https://teleport-bc185-default-rtdb.firebaseio.com';

firebaseAdmin.initializeApp({
    credential: firebaseAdmin.credential.cert(require(serviceAccount)),
    databaseURL: firebaseUrl
});

const firestore = firebaseAdmin.firestore();
const stripe = require('stripe')(functions.config().stripe.key)

const generateresponse = function (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.status
            };
        case 'requires_payment_method':
            return {
                "error": "Your Card was denied, please provide a new payment method",
            };
        case 'succeeded':
            return { clientSecret: intent.clientSecret, status: intent.status, intent: intent };

    }
    return { error: "Failed" }
}
exports.StripePayEndPointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, amount, currency, useStripeSdk } = req.body;
    // const orderAmount = 1000;
    const orderAmount = amount * 100;
    try {

        if (paymentMethodId) {
            const params = {
                amount: orderAmount,
                confirm: true,
                confirmation_method: 'manual',
                currency: "usd",
                payment_method: paymentMethodId,
                use_stripe_sdk: useStripeSdk
            }
            const intent = await stripe.paymentIntents.create(params);
            console.log({ intent })
            return res.send(
                generateresponse(intent)
            );

        }
        return res.sendStatus(400)
    } catch (e) {
        console.log(e.message);
        res.send({ error: e.message });
    }
});
exports.StripePayEndPointIntentId = functions.https.onRequest(async (req, res) => {

    const { paymentIntentId } = req.body;
    try {
        if (paymentIntentId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId)
            console.log((intent))
            return res.send(
                intent
            );
        }
    } catch (error) {
        console.log(error);
        return res.send(
            error
        );
    }
});


