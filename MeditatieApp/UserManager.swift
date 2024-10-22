//
//  UserManager.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 10/10/2024.
//

import Foundation

class UserManager {
    
    static var sharedUser = UserManager()
    
    private let userKey = "userData"
    
    func saveUser(_ user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        } else {
            print("User data not saved, tried though")
        }
    }
    
    func loadUser() -> User {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            print("User data loaded succesfully. Coins: \(user.coins)")
            return user
        }
        print("User data not found.")
        return User(id: UUID(), coins: 0, meditationsCompleted: 0, minutesMeditated: 0, achievements: [:], unlockedHats: [], equippedHat: "", unlockedBackgrounds: ["Default Background"], equippedBackground: "Default Background", unlockedSoundtracks: [], equippedSoundtrack: "")
    }
    
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}
