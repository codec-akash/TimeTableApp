const express = require("express");
const app = express();
require("dotenv").config();
const mongoose = require("mongoose");
const morgan = require("morgan");
const bodyParser = require("body-parser");

//Declaring Routes
const eventsRoutes = require("./api/routes/events");

// Connect to db.
mongoose.connect(
  "mongodb+srv://Events:" +
    process.env.ATLASS_PASS +
    "@timetable.xmj86.mongodb.net/"+ process.env.DATABASE_NAME +"?retryWrites=true&w=majority" , 
    { useCreateIndex: true , useUnifiedTopology: true , useNewUrlParser: true },
    console.log("Connected")
);

// After Connecting to DB.
app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//Preventing CORS Errors..
app.use((req, res, next) => {
  res.header("Acess-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-headers",
    "origin, X-Requested-With, Content-Type , Authorization"
  );

  if (res.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

//Routes...
app.use("/events", eventsRoutes);

//All the errors are handled here including Database errors or the complete application errpr
app.use((error, req, res, next) => {
  res.status(error.status || 500);
  res.json({
    error: {
      msg: "Error Occured in app.js",
      message: error.message,
    },
  });
});

module.exports = app;
