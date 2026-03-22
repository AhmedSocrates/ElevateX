import mongoose from 'mongoose';

// --- Career Path Schema ---
const careerPathSchema = new mongoose.Schema({
    title: { type: String, required: true },
    slug: { type: String, required: true, unique: true },
    description: { type: String },
    themeColor: { type: String },
    iconName: { type: String },
    totalNodes: { type: Number, default: 0 },
    isActive: { type: Boolean, default: true }
}, { timestamps: true });

// --- Node Schema ---
const nodeSchema = new mongoose.Schema({
    pathId: { 
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'CareerPath', 
        required: true 
    },
    orderIndex: { type: Number, required: true },
    title: { type: String, required: true },
    type: { 
        type: String, 
        enum: ['reading', 'multiple_choice', 'drag_and_drop'], 
        required: true 
    },
    xpReward: { type: Number, default: 10 },
    // Schema.Types.Mixed allows for flexible JSON structures based on the 'type'
    content: { type: mongoose.Schema.Types.Mixed, required: true }
}, { timestamps: true });

// Exporting the schemas to be used by the seeder
export const CareerPath = mongoose.model('CareerPath', careerPathSchema);
export const Node = mongoose.model('Node', nodeSchema);