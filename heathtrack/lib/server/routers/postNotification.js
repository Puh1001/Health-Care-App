const express = require("express");
const notiRouter = express.Router();
const {initializeApp, cert} = require('firebase-admin/app');
require('dotenv');
const admin = require('firebase-admin');

notiRouter.post("/api/notications", async(req, res)=> {
    const device_token_emulator = process.env.DEVICE_TOKEN;
    
    try {
        async function sendToDevice(token, data) {
            await admin.messaging().sendToDevice(
                token,
                {
                    data: data
                },
                {
                    contentAvailable: true,
                    priority: "high",
                }
            )
        }
        sendToDevice(device_token_emulator, message)
    } catch (err) {
        res.status(500).json({Error: err.message});
    }
})

// initializeApp({
//     credential: cert(serviceAccount)
    
// })

message = {
    message: "hello",
}
