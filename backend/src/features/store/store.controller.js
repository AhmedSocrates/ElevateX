import User from '../users/user.model.js';


const STORE_ITEMS = [
  { id: 'streak_pauser', name: 'Streak Pauser', price: 50, type: 'utility', description: 'Saves your streak if you miss a day.' },
  { id: 'xp_potion', name: '2x XP Potion', price: 80, type: 'boost', description: 'Double XP for your next completed task.' },
  { id: 'theme_cyberpunk', name: 'Cyberpunk Theme', price: 150, type: 'cosmetic', description: 'Unlock the neon Cyberpunk profile theme.' }
];

export const getStoreItems = (req, res) => {
  res.status(200).json({ items: STORE_ITEMS });
};

export const buyItem = async (req, res) => {
  try {
    const { itemId } = req.body;

    const itemToBuy = STORE_ITEMS.find(item => item.id === itemId);
    if (!itemToBuy) return res.status(404).json({ message: "Item not found in store." });

    const user = await User.findById(req.user.userId);

    // Check if they have enough gems
    if (user.stats.gems < itemToBuy.price) {
      return res.status(400).json({ message: "Not enough gems!" });
    }

    // Process the transaction
    if (itemId === 'streak_pauser') {
      user.inventory.streakPausers += 1;
      
    } else if (itemId === 'xp_potion') {
      user.inventory.xpPotions += 1;
      
    } else if (itemId === 'theme_cyberpunk') {
      // Prevent buying the same theme twice
      if (user.inventory.unlockedThemes.includes('theme_cyberpunk')) {
        return res.status(400).json({ message: "You already own this theme!" });
      }
      user.inventory.unlockedThemes.push('theme_cyberpunk');
    }

    // Deduct gems AFTER we confirm the purchase is valid
    user.stats.gems -= itemToBuy.price;
    
    await user.save();

    res.status(200).json({ 
      message: `Successfully purchased ${itemToBuy.name}!`, 
      gemsRemaining: user.stats.gems,
      inventory: user.inventory 
    });

  } catch (error) {
    console.error("Store Purchase Error:", error);
    res.status(500).json({ message: "Server error during purchase." });
  }
};