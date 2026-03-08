import express from 'express';
import {getMyProfile,updateProfile,updateSettings} from './user.controller.js';
import {protectRoute} from '../../middlewares/auth.middlewares.js';
import { streakEngine } from '../../middlewares/streak.middleware.js';
const router = express.Router();
router.get('/me', protectRoute, streakEngine, getMyProfile);
router.put('/profile', protectRoute, streakEngine, updateProfile);
router.put('/settings', protectRoute, streakEngine, updateSettings);
export default router;