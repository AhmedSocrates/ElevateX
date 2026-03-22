import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

// 1. Recreate __dirname for ES Modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 2. Tell dotenv exactly where the .env file is (one folder up from src)
dotenv.config({ path: path.resolve(__dirname, '../.env') });

import express from 'express';
import cors from 'cors';
import connectDB from './config/db.js';
import authRoutes from './features/auth/auth.routes.js';
import userRoutes from './features/users/user.routes.js';
import storeRoutes from './features/store/store.routes.js';
import pathsRoutes from './features/paths/paths.routes.mjs';

const app = express();
const PORT = process.env.PORT || 3000;
// 1. Global Middleware
app.use(cors()); // Allows Flutter app to make requests
app.use(express.json()); // Allows the server to accept JSON data in the body

// 2. Basic Test Route
app.get('/', (req, res) => {
  res.send({ message: "Welcome to the ElevateX API!" });
});
app.use('/api/auth', authRoutes);
app.use('/api/users', userRoutes);
app.use('/api/store', storeRoutes);
app.use('/api/paths', pathsRoutes);

// 3. Start the Server
app.listen(PORT, async () => {
  console.log(` Server is running on http://localhost:${PORT}`);
  
  // 4. Connect to MongoDB  (happens only once the server starts)
  await connectDB(); 
});