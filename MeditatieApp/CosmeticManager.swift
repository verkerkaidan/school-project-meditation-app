//
//  CosmeticManager.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 16/10/2024.
//

import Foundation
import SwiftUI
import UIKit

// Define a model for the Cosmetic Item

// Manager class to handle available cosmetics
class CosmeticManager {
    
    // Array to store available cosmetics
    var allHats: [HatCosmetic] = []
    var allBackgrounds: [BackgroundCosmetic] = []
    var allSoundtracks: [SoundtrackCosmetic] = []
    
    // Initializer to set up the available cosmetics
    init() {
        loadAvailableHats()
        loadAvailableBackgrounds()
        loadAvailableSoundtracks()
    }
    
    // Load predefined cosmetics
    private func loadAvailableHats() {
        allHats = [
            HatCosmetic(id: 1, name: "Wizard", price: 50, imageName: "wizard"),
            HatCosmetic(id: 2, name: "Waterwave", price: 50, imageName: "waterwave"),
            HatCosmetic(id: 3, name: "Top Hat", price: 75, imageName: "tophat"),
            HatCosmetic(id: 4, name: "Tiara", price: 100, imageName: "tiara"),
            HatCosmetic(id: 5, name: "Sunburst", price: 50, imageName: "sunburst"),
            HatCosmetic(id: 6, name: "Farmer", price: 50, imageName: "farmer"),
            HatCosmetic(id: 7, name: "Pirate", price: 75, imageName: "pirate"),
            HatCosmetic(id: 8, name: "Sleepy", price: 100, imageName: "sleepy"),
            HatCosmetic(id: 9, name: "Lotus", price: 50, imageName: "lotus"),
            HatCosmetic(id: 10, name: "Flowercrown", price: 50, imageName: "flowercrown"),
            HatCosmetic(id: 11, name: "Crown", price: 75, imageName: "crown"),
            HatCosmetic(id: 12, name: "Construction", price: 100, imageName: "construction"),
            HatCosmetic(id: 13, name: "Default Appearance", price: 0, imageName: "defaultappearance")
        ]
        
        allHats = allHats.sorted { $0.price < $1.price }
    }
    private func loadAvailableBackgrounds() {
        allBackgrounds = [
            BackgroundCosmetic(id: 1, name: "Default Background", price: 0, imageName: "defaultbackground"),
            BackgroundCosmetic(id: 2, name: "Ocean Background", price: 30, imageName: "oceanbackground"),
            BackgroundCosmetic(id: 3, name: "Nightsky Background", price: 30, imageName: "nightskybackground"),
            BackgroundCosmetic(id: 4, name: "Sunny Beach Background", price: 35, imageName: "sunnybeachbackground"),
            BackgroundCosmetic(id: 5, name: "Mountain Background", price: 75, imageName: "mountainbackground"),
            BackgroundCosmetic(id: 6, name: "Underwater Background", price: 50, imageName: "underwaterbackground"),
            BackgroundCosmetic(id: 7, name: "Palace Background", price: 100, imageName: "palacebackground")
        ]
        
        allBackgrounds = allBackgrounds.sorted { $0.price < $1.price }
    }
    private func loadAvailableSoundtracks() {
        allSoundtracks = [
            SoundtrackCosmetic(id: 1, name: "Default", price: 0, imageName: "systemImage: music.note"),
            SoundtrackCosmetic(id: 2, name: "Relaxing Music", price: 75, imageName: "systemImage: music.note"),
            SoundtrackCosmetic(id: 3, name: "Healing Sounds", price: 100, imageName: "systemImage: music.note"),
            SoundtrackCosmetic(id: 4, name: "Sleep Music", price: 100, imageName: "systemImage: music.note"),
            SoundtrackCosmetic(id: 5, name: "Water Mill", price: 150, imageName: "systemImage: music.note")
        ]
    }
    
    // Fetch all available cosmetics
    func getAllHatCosmetics() -> [HatCosmetic] {
        return allHats
    }
    
    func getAllBackgroundCosmetics() -> [BackgroundCosmetic] {
        return allBackgrounds
    }
    
    func getAllSoundtrackCosmetics() -> [SoundtrackCosmetic] {
        return allSoundtracks
    }
    
    // Get a cosmetic by its ID
    func getHatCosmetic(byId id: Int) -> HatCosmetic? {
        return allHats.first { $0.id == id }
    }
    
    // Add a new cosmetic to the list (optional feature)
    func addHatCosmetic(item: HatCosmetic) {
        allHats.append(item)
    }
    
    // Remove a cosmetic by ID (optional feature)
    func removeHatCosmetic(byId id: Int) {
        allHats.removeAll { $0.id == id }
    }
}
