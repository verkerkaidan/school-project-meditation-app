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
    @Published var unlockedHats: [String]
    @Published var equippedHat: String
    @Published var unlockedBackgrounds: [String]
    @Published var equippedBackground: String
    @Published var unlockedSoundtracks: [String]
    @Published var equippedSoundtrack: String
    
    let userManager = UserManager()
    
    enum CodingKeys: CodingKey {
        case id, coins, meditationsCompleted, minutesMeditated, achievements, unlockedHats, equippedHat, unlockedBackgrounds, equippedBackground, unlockedSoundtracks, equippedSoundtrack
    }
    
    init(id: UUID, coins: Int, meditationsCompleted: Int, minutesMeditated: Int, achievements: [String: Bool], unlockedHats: [String], equippedHat: String, unlockedBackgrounds: [String], equippedBackground: String, unlockedSoundtracks: [String], equippedSoundtrack: String) {
        self.id = id
        self.coins = coins
        self.meditationsCompleted = meditationsCompleted
        self.minutesMeditated = minutesMeditated
        self.achievements = achievements
        self.unlockedHats = unlockedHats
        self.equippedHat = equippedHat
        self.unlockedBackgrounds = unlockedBackgrounds
        self.equippedBackground = equippedBackground
        self.unlockedSoundtracks = unlockedSoundtracks
        self.equippedSoundtrack = equippedSoundtrack
        
        self.unlockHat("Default Appearance")
        self.equipHat("Default Appearance")
        self.unlockBackground("Default Background")
        self.equipBackground("Default Background")
        self.unlockSoundtrack("Default")
        self.equipSoundtrack("Default")
    }
    
    // Function to unlock a cosmetic
    func unlockHat(_ cosmeticName: String) {
        if !unlockedHats.contains(cosmeticName) {
            unlockedHats.append(cosmeticName)
            UserManager.sharedUser.saveUser(self)
        }
    }
    
    // Function to equip a cosmetic
    func equipHat(_ cosmeticName: String) {
        if unlockedHats.contains(cosmeticName) {
            equippedHat = cosmeticName
            userManager.saveUser(self)
        }
    }
    
    func unlockBackground(_ cosmeticName: String) {
        if !unlockedBackgrounds.contains(cosmeticName) {
            unlockedBackgrounds.append(cosmeticName)
            UserManager.sharedUser.saveUser(self)
        }
    }
    
    // Function to equip a cosmetic
    func equipBackground(_ cosmeticName: String) {
        if unlockedBackgrounds.contains(cosmeticName) {
            equippedBackground = cosmeticName
            userManager.saveUser(self)
        }
    }
    
    func unlockSoundtrack(_ cosmeticName: String) {
        if !unlockedSoundtracks.contains(cosmeticName) {
            unlockedSoundtracks.append(cosmeticName)
            UserManager.sharedUser.saveUser(self)
        }
    }
    
    // Function to equip a cosmetic
    func equipSoundtrack(_ cosmeticName: String) {
        if unlockedSoundtracks.contains(cosmeticName) {
            equippedSoundtrack = cosmeticName
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
        unlockedHats = try container.decode([String].self, forKey: .unlockedHats)
        equippedHat = try container.decode(String.self, forKey: .equippedHat)
        unlockedBackgrounds = try container.decode([String].self, forKey: .unlockedBackgrounds)
        equippedBackground = try container.decode(String.self, forKey: .equippedBackground)
        unlockedSoundtracks = try container.decode([String].self, forKey: .unlockedSoundtracks)
        equippedSoundtrack = try container.decode(String.self, forKey: .equippedSoundtrack)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(coins, forKey: .coins)
        try container.encode(meditationsCompleted, forKey: .meditationsCompleted)
        try container.encode(minutesMeditated, forKey: .minutesMeditated)
        try container.encode(achievements, forKey: .achievements)
        try container.encode(unlockedHats, forKey: .unlockedHats)
        try container.encode(equippedHat, forKey: .equippedHat)
        try container.encode(unlockedBackgrounds, forKey: .unlockedBackgrounds)
        try container.encode(equippedBackground, forKey: .equippedBackground)
        try container.encode(unlockedSoundtracks, forKey: .unlockedSoundtracks)
        try container.encode(equippedSoundtrack, forKey: .equippedSoundtrack)
    }
}

