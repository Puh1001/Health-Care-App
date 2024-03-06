const fs = require("fs");
const interval = 1000; // 30 minutes in milliseconds

function sendData() {
  fs.readFile("data.json", "utf8", (err, data) => {
    if (err) {
      console.error("Error reading data.json:", err);
      return;
    }

    const jsonData = JSON.parse(data);
    const objectToSend = jsonData.shift(); // Remove the first object from the array

    // Add current timestamp to the object
    objectToSend.timestamp = Date.now();

    fetch("http://localhost:8080/api/heath-data", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(objectToSend),
    })
      .then((response) => {
        if (!response.ok) {
          console.error("Error sending data:", response.status);
        } else {
          console.log("Data sent successfully!");
        }
      })
      .catch((error) => {
        console.error("Error sending data:", error);
      });
  });
}

sendData(); // Send the first object immediately
setInterval(sendData, interval); // Schedule sending subsequent objects
