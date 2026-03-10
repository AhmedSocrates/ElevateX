// src/features/paths/paths.routes.js
import express from 'express';
import { getPaths, getPathNodes } from './paths.controller.mjs';

const router = express.Router();

// GET /api/paths
router.get('/', getPaths);

// GET /api/paths/:pathId/nodes
router.get('/:pathId/nodes', getPathNodes);

export default router;