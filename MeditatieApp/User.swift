//
//  User.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import Foundation

class User: ObservableObject, Identifiable, Codable {
    let id: UUID
    @Published var coins: Int
    @Published var meditationsCompleted: Int
    @Published var minutesMeditated: Int
    @Published var achievements: [String: Bool]
    @Published var unlockedCosmetics: [String]
    @Published var equippedHat: String
    
    let userManager = UserManager()
    
    enum CodingKeys: CodingKey {
        case id, coins, meditationsCompleted, minutesMeditated, achievements, unlockedCosmetics, equippedHat
    }
    
    init(id: UUID, coins: Int, meditationsCompleted: Int, minutesMeditated: Int, achievements: [String: Bool], unlockedCosmetics: [String], equippedHat: String) {
        self.id = id
        self.coins = coins
        self.meditationsCompleted = meditationsCompleted
        self.minutesMeditated = minutesMeditated
        self.achievements = achievements
        self.unlockedCosmetics = unlockedCosmetics
        self.equippedHat = equippedHat
    }
    
    // Function to unlock a cosmetic
    func unlockCosmetic(_ cosmeticName: String) {
        if !unlockedCosmetics.contains(cosmeticName) {
            unlockedCosmetics.append(cosmeticName)
            UserManager.sharedUser.saveUser(self)
        }
    }
    
    // Function to equip a cosmetic
    func equipCosmetic(_ cosmeticName: String) {
        if unlockedCosmetics.contains(cosmeticName) {
            equippedHat = cosmeticName
            userManager.saveUser(self)
        }
    }
    
    func updateCoins(by: Int) {
        self.coins += by
        UserManager.sharedUser.saveUser(self)
    }
    
    func updateMeditationsCompleted(by: Int) {
        self.meditationsCompleted += by
        UserManager.sharedUser.saveUser(self)
        checkAchievements()
    }
    
    func updateMinutesMeditated(by: Int) {
        self.minutesMeditated += by
        UserManager.sharedUser.saveUser(self)
        checkAchievements()
    }
    
    func unlockAchievement(_ achievement: String) {
        achievements[achievement] = true
        updateCoins(by: 100) // Reward for unlocking achievement
        UserManager.sharedUser.saveUser(self)
    }
    
    func checkAchievements() {
        let achievementsList = [
            "A Calm Start": (description: "Meditate a total of 1 time.", target: 1),
            "Peaceful Moments": (description: "Meditate a total of 3 times.", target: 3),
            "Mindful Steps": (description: "Meditate a total of 5 times.", target: 5),
            "Tranquil Journey": (description: "Meditate a total of 10 times.", target: 10),
            "Serene Focus": (description: "Meditate a total of 25 times.", target: 25),
            "Harmony Within": (description: "Meditate a total of 50 times.", target: 50),
            "Zen Master": (description: "Meditate a total of 100 times.", target: 100),
            "Stillness Sage": (description: "Meditate a total of 200 times.", target: 200),
            "Mindful Guru": (description: "Meditate a total of 500 times.", target: 500),
            "Enlightened One": (description: "Meditate a total of 1000 times.", target: 1000)
        ]
        
        for (achievement, details) in achievementsList {
            if meditationsCompleted >= details.target && !(achievements[achievement] ?? false) {
                unlockAchievement(achievement)
            }
        }
    }
    
    // Custom encoding and decoding because of @Published
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        coins = try container.decode(Int.self, forKey: .coins)
        meditationsCompleted = try container.decode(Int.self, forKey: .meditationsCompleted)
        minutesMeditated = try container.decode(Int.self, forKey: .minutesMeditated)
        achievements = try container.decode([String: Bool].self, forKey: .achievements)
        unlockedCosmetics = try container.decode([String].self, forKey: .unlockedCosmetics)
        equippedHat = try container.decode(String.self, forKey: .equippedHat)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(coins, forKey: .coins)
        try container.encode(meditationsCompleted, forKey: .meditationsCompleted)
        try container.encode(minutesMeditated, forKey: .minutesMeditated)
        try container.encode(achievements, forKey: .achievements)
        try container.encode(unlockedCosmetics, forKey: .unlockedCosmetics)
        try container.encode(equippedHat, forKey: .equippedHat)
    }
}

