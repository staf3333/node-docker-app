"use strict";

const express = require("express");

// constants
const PORT = 8080;

// localhost = "127.0.0.1"
// listen on any available network interface (will include localhost or anything that wants to access!)
const HOST = "0.0.0.0";

// start app
const app = express();

app.get("/", (req, res) => {
  res.send("Hello World");
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
