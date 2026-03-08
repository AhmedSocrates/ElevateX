import User from '../users/user.model.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

// 1. Register a new user
export const registerUser = async (req, res) => {
    try {
        const { username, email,password } = req.body;
        const existingUser = await User.findOne({email});
        if (existingUser) {
            return res.status(400).json({ message: "Email already in use. Please choose another email."});
        }
        // Hash the password before saving
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password,salt);

        const newUser = new User({
            username,
            email,
            passwordHash: hashedPassword,
        });
        await newUser.save();

        // Generate JWT token
        const token = jwt.sign(
            {userId: newUser._id},
            process.env.JWT_SECRET,
            {expiresIn: '30d'}
        );

        res.status(201).json({
            message: "User registered successfully.",
            token,
            user: {
                id: newUser._id,
                username: newUser.username,
                email: newUser.email,
                level: newUser.stats.level,
            }
        });

    } catch (error){
        console.error("Registration error:", error);
        res.status(500).json({ message: "Server error during registration. "});
    }
}
export const loginUser = async (req, res) => {
    try {
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if (!user) {
            return res.status(400).json({ message: "Invalid email or password."});
        }
        const isMatch = await bcrypt.compare(password, user.passwordHash);
        if (!isMatch) {
        return res.status(400).json({ message: "Invalid email or password." });
        }
        // Generate JWT token
        const token = jwt.sign(
            { userId: user._id},
            process.env.JWT_SECRET,
            { expiresIn: '30d' }
        );
        // 5. Send the success response!
        res.status(200).json({
            message: "Login successful!",
            token: token,
            user: {
                id: user._id,
                username: user.username,
                email: user.email,
                level: user.stats.level
            }
            });

        } catch (error) {
            console.error("Login Error:", error);
            res.status(500).json({ message: "Server error during login." });
        }
};