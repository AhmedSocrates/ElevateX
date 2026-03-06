require('dotenv').config(); // MUST be the first line to load variables
const express = require('express');
const cors = require('cors');
const connectDB = require('./config/db');

const app = express();
const PORT = process.env.PORT || 3000;

// 1. Connect to MongoDB Atlas
connectDB();

// 2. Global Middleware
app.use(cors()); // Allows your Flutter app to make requests
app.use(express.json()); // Allows the server to accept JSON data in the body

// 3. Basic Test Route
app.get('/', (req, res) => {
  res.send({ message: "Welcome to the ElevateX API!" });
});

// 4. Start the Server
app.listen(PORT, () => {
  console.log(`🚀 Server is running on http://localhost:${PORT}`);
});