import mongoose from 'mongoose';

const guildSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  description: { type: String, required: true },
  isDefault: { type: Boolean, default: false }, // True for the starter guilds!
  creator: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }, // Null for default guilds
  members: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  requiredLevel: { type: Number, default: 1 } // For when high-rated users make guilds later
}, { timestamps: true });

export default mongoose.model('Guild', guildSchema);