import express from 'express';
import { getStoreItems, buyItem } from './store.controller.js';
import { protectRoute } from '../../middlewares/auth.middleware.js';

const router = express.Router();

// Get the catalog (Users must be logged in to see the store)
router.get('/', protectRoute, getStoreItems);

// Buy an item (Requires the item ID in the JSON body)
router.post('/buy', protectRoute, buyItem);

export default router;