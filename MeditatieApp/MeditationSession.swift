//
//  MeditationSession.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 10/10/2024.
//

import Foundation

struct MeditationSession: Identifiable, Codable {
    var id: UUID
    var date: Date
    var duration: TimeInterval
    
    init(duration: TimeInterval) {
        self.id = UUID()
        self.date = Date()
        self.duration = duration
    }
}
