import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
        unique: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        lowercase: true,
    },
    passwordHash: {
        type: String, 
        required: true,
    }, 
    avatarUrl: {
        type: String, 
        default: "https://example.com/default-avatar.png"
    },
    lastActivityAt: {
        type: Date, 
        default: Date.now,

    },
    stats: {
        xp:{ type:Number, default:0},
        level:{type:Number, default: 1},
        gems: {type:Number, default: 0},
        currentStreak: {type:Number, default:0},
        longestStreak: {type:Number, default:0},

    },
    settings: {
        muteSounds: {type:Boolean, default:false},
        pushNotifications: {type:Boolean, default:true}
    },
    inventory: {
        streakPausers: {type:Number, default:0},
        unlockedBadges: [{type: mongoose.Schema.Types.ObjectId, ref: 'StoreItem'}],
    },
    activePathId: {
        type: mongoose.Schema.Types.ObjectId,
        ref:'Path',
        default: null,
    }
    },
    { timestamps: true,}
);

const User = mongoose.model('User', userSchema);
export default User;