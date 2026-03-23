import mongoose from 'mongoose';

const messageSchema = new mongoose.Schema({
  guildId: { type: mongoose.Schema.Types.ObjectId, ref: 'Guild', required: true },
  sender: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  content: { type: String, required: true }
}, { timestamps: true });

export default mongoose.model('Message', messageSchema);