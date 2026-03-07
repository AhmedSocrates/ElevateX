import 'dotenv/config';// MUST be the first line to load variables
 
import express from 'express';
import cors from 'cors';
import connectDB from './config/db.js';

const app = express();
const PORT = process.env.PORT || 3000;

// 1. Global Middleware
app.use(cors()); // Allows Flutter app to make requests
app.use(express.json()); // Allows the server to accept JSON data in the body

// 2. Basic Test Route
app.get('/', (req, res) => {
  res.send({ message: "Welcome to the ElevateX API!" });
});

// 3. Start the Server
app.listen(PORT, async () => {
  console.log(` Server is running on http://localhost:${PORT}`);
  
  // 4. Connect to MongoDB  (happens only once the server starts)
  await connectDB(); 
});