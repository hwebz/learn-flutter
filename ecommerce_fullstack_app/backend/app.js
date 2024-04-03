const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const mongoose = require('mongoose');
require('dotenv').config();

const app = express();
const env = process.env;

// body-parser
app.use(bodyParser.json());
// morgan
app.use(morgan('tiny'));
// cors
app.use(cors());
app.options('*', cors());

/*
 * Sample middlewares
app.use((_, __, next) => {
  console.log('A request has been made to your server');
  next();
})

app.use((_, __, next) => {
  console.log('This is the second middleware');
  next();
})

const authorization = (_, response, next) => {
  const isAuthorized = false;
  if (isAuthorized) {
    console.log('User is authorized');
    return next();
  } else {
    return response.status(401).send('Unauthorized');
  }
}

app.get('/', (request, response) => {
  return response.status(200).send('Sorry, can\'t find that!');
})

app.get('/watch/videos/:id', authorization, (request, response) => {
  return response.json({ videoId: request.params.id});
})
*/

// Start the server
const hostname = env.HOSTNAME
const port = env.PORT

mongoose.connect(env.MONGODB_CONNECTION_STRING).then(() => {
  console.log('Connected to MongoDB');
}).catch(error => {
  console.error('Error connecting to MongoDB:', error.message);
});

app.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}`);
});

app.get('/', (req, res) => {
  res.send('Hello World');
})