import User from './user.model.js';

export const getMyProfile = async (req, res) => {
    try{
    const user = await User.findById(req.user.userId).select('-passwordHash');
    if (!user) {
        return res.status(404).json({ message: "User not found." });
    } 
    res.status(200).json({ user });
}
    catch (error) {
        return res.status(500).json({ message: "Server error while fetching profile." });
}
}

export const updateProfile = async (req, res) => {
    try {
        const { username, avatarUrl } = req.body;
        const updatedUser = await User.findByIdAndUpdate(req.user.userId,
            {$set: { username: username, avatarUrl: avatarUrl}},
            { returnDocument: 'after', runValidators: true }
        ).select('-passwordHash');
        res.status(200).json({ message: "Profile updated successfully.", updatedUser }); 
    } catch (error) {
        console.error("Profile update error:", error);
        res.status(500).json({ message: "Server error while updating profile." });
    }
}

export const updateSettings = async (req, res) => {
  try {
    const { muteSounds, pushNotifications } = req.body;

    // We use dot notation to specifically target nested settings
    const updatedUser = await User.findByIdAndUpdate(
      req.user.userId,
      { 
        $set: { 
          'settings.muteSounds': muteSounds, 
          'settings.pushNotifications': pushNotifications 
        } 
      },
      { new: true, runValidators: true }
    ).select('-passwordHash');

    res.status(200).json({ message: "Settings updated successfully", user: updatedUser });
  } catch (error) {
    console.error("Update Settings Error:", error);
    res.status(500).json({ message: "Server error updating settings." });
  }
};