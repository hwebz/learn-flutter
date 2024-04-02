const express = require('express');
require('dotenv').config();

const app = express();
const env = process.env;

// Start the server
const hostname = env.HOSTNAME
const port = env.PORT

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}`);
});