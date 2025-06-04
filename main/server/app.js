const express = require('express');
const mongoose = require('mongoose');

const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = express();
const DB = "mongodb+srv://Beube:qmqp1234!@cluster0.l6h5uko.mongodb.net/test2?retryWrites=true&w=majority";

const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);
const messages = [];

io.on('connection', (socket) => {
  console.log(`User connected: ${socket.id}`);


  socket.on('message', (data) => {
    console.log(`Received message from ${data.senderUsername}: ${data.message}`);

    const messages = {
      message: data.message,
      senderUsername: data.senderUsername,
    };

    io.emit('message', messages);
  });
});

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// create API
// get, put, post, delete, update CRUD

// connection
mongoose.connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });

server.listen(3000, () => {
  console.log('listening on *:3000');
});