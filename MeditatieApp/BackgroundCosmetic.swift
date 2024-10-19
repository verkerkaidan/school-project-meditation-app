//
//  BackgroundCosmetic.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 17/10/2024.
//

import Foundation
import SwiftUI

struct BackgroundCosmetic {
    let id: Int
    let name: String
    let price: Int
    let imageResource: Image?
    
    // Convenience initializer for image name
    init(id: Int, name: String, price: Int, imageName: String) {
        self.id = id
        self.name = name
        self.price = price
        self.imageResource = Image(imageName.lowercased())
    }
}
