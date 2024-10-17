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
    private var allHats: [HatCosmetic] = []
    
    // Initializer to set up the available cosmetics
    init() {
        loadAvailableHats()
    }
    
    // Load predefined cosmetics
    private func loadAvailableHats() {
        allHats = [
            HatCosmetic(id: 1, name: "Top Hat", price: 10, imageName: "tophat"),
            HatCosmetic(id: 2, name: "Straw Hat", price: 10, imageName: "strawhat"),
            HatCosmetic(id: 3, name: "Tiara", price: 15, imageName: "tiara"),
            HatCosmetic(id: 4, name: "Crown", price: 20, imageName: "crown")
        ]
    }
    
    // Fetch all available cosmetics
    func getAllHatCosmetics() -> [HatCosmetic] {
        return allHats
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
