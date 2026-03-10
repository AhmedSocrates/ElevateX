// seeder.js
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

// 1. Recreate __dirname for ES Modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 2. Tell dotenv to look 4 folders up to reach env
dotenv.config({ path: path.resolve(__dirname, '../../../../.env') });

import connectDB from '../../../config/db.js'; 
import { CareerPath, Node } from '../paths.model.js'; 
import { careerPathsData, nodesData } from './data.js';

const importData = async () => {
  try {
    // 1. Connect to the database
    await connectDB();

    // 2. Clear out any existing data to prevent duplicates
    await CareerPath.deleteMany();
    await Node.deleteMany();
    console.log('Old data cleared...');

    // 3. Insert the new data
    await CareerPath.insertMany(careerPathsData);
    await Node.insertMany(nodesData);
    
    console.log('Data successfully imported');
    process.exit(); // Exit process successfully
    
  } catch (error) {
    console.error(`Error importing data: ${error.message}`);
    process.exit(1); // Exit process with failure
  }
};

// Execute the function
importData();