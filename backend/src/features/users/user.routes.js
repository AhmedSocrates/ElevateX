import express from 'express';
import {getMyProfile,updateProfile,updateSettings} from './user.controller.js';
import {protectRoute} from '../../middlewares/auth.middlewares.js';

const router = express.Router();
router.get('/me', protectRoute, getMyProfile);
router.put('/profile', protectRoute, updateProfile);
router.put('/settings', protectRoute, updateSettings);
export default router;