const express = require("express");

const {initializeApp, cert} = require('firebase-admin/app');

require('dotenv');

const device_token_emulator = process.env.DEVICE_TOKEN;

var serviceAccount = require('../../data/health-care-project-f7c4d-firebase-adminsdk-pt7fy-faad4d8dfc.json');

var admin = require('firebase-admin');

initializeApp({
    credential: cert(serviceAccount)
})

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


message = {

    message: "hello",
}

sendToDevice(device_token_emulator, message)