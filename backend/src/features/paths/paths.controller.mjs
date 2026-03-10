import { CareerPath, Node } from './paths.model.mjs';

// @desc    Get all active career paths
// @route   GET /api/paths
// @access  Public
export const getPaths = async (req, res) => {
    try {
        // Fetch the required paths and exclude the __v field that Mongoose adds
        const paths = await CareerPath.find({ isActive: true }).select('-__v');
        res.status(200).json(paths);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching career paths', error: error.message });
    }
};

// @desc    Get all nodes for a specific career path
// @route   GET /api/paths/:pathId/nodes
// @access  Public
export const getPathNodes = async (req, res) => {
    try {
        const { pathId } = req.params;
        
        // Fetch nodes for this specific path, sorted by their orderIndex
        const nodes = await Node.find({ pathId })
                                .sort({ orderIndex: 1 })
                                .select('-__v');
                                
        res.status(200).json(nodes);
    } catch (error) {
        res.status(500).json({ message: 'Error fetching path nodes', error: error.message });
    }
};