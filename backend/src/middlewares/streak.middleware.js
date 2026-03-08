import User from '../features/users/user.model.js';

export const streakEngine = async (req, res, next) => {
    try {
        const user = await User.findById(req.user.userId);
        if (!user) {
            return res.status(404).json({ message: "User not found." });
        }
        const now = new Date();
        const lastActivity = user.lastActivityAt || new Date(0); // Default to epoch if no activity
        
        const todayDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        const lastActivityDate = new Date(lastActivity.getFullYear(), lastActivity.getMonth(), lastActivity.getDate());
        
        const timeDiff = todayDate - lastActivityDate;
        const dayDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24));

        let needsSaving = false;
        // 3. APPLY THE ACCEPTANCE CRITERIA LOGIC
        if (dayDiff === 1) {
        // 1 day has passed -> Increment streak
        user.stats.currentStreak += 1;
        needsSaving = true;

        } else if (dayDiff > 1) {
        // >1 day has passed -> Check for Streak Pauser
        if (user.inventory && user.inventory.streakPausers > 0) {
            // Consume the pauser, keep the streak as is!
            user.inventory.streakPausers -= 1;
        } else {
            // No pauser? Reset to 0 
            user.stats.currentStreak = 0;
        }
        needsSaving = true;
        }

        // 4. If it's a new day (or their very first time), update the timestamp
        if (dayDiff > 0 || !user.lastActivityAt) {
        user.lastActivityAt = now;
        needsSaving = true;
        }

        // 5. Only ping the database if we actually changed something! (Saves performance)
        if (needsSaving) {
        await user.save();
        }

        // 6. Move on to the actual route they were trying to hit (like getMyProfile)
        next();

    } catch (error) {
        console.error("Streak Engine Error:", error);
        // Don't crash their request just because the streak engine had a hiccup
        next(); 
    }
    };