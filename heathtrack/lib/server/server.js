//import from pakage
const express = require("express");
const mongoose = require("mongoose");
const morgan = require("morgan");
const app = express();
const DB =
  "mongodb+srv://hoangvn2phu:Puh1001@cluster0.crhav37.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
require("dotenv").config();

//import from another files
const authRouter = require("./routers/auth");
const heathDataRouter = require("./routers/heathData");
const port = process.env.PORT || 8080;
const hostname = process.env.HOST_NAME;

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

//middleware
app.use(authRouter);
app.use(heathDataRouter);
//connection
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connect Sucessfully !!!!");
  })
  .catch((err) => {
    console.log(err);
  });

app.use(morgan("combined"));

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, "0.0.0.0", () => {
  console.log(`App listening at http://localhost:${port}`);
});
