//
//  MeditationSessionManager.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 10/10/2024.
//

import Foundation

class MeditationSessionManager: ObservableObject {    
    private let sessionsKey = "meditationData"
    
    func saveSession(_ session: MeditationSession) {
        var sessions = loadSessions()
        sessions.append(session)
        if let encoded = try? JSONEncoder().encode(sessions) {
            print("Meditation Session Saved!")
            UserDefaults.standard.set(encoded, forKey: sessionsKey)
        }
    }
    
    func loadSessions() -> [MeditationSession] {
        if let data = UserDefaults.standard.data(forKey: sessionsKey),
           let sessions = try? JSONDecoder().decode([MeditationSession].self, from: data) {
            print(sessions)
            return sessions
        }
        print("No sessions found")
        return []
    }
    
    func clearSessions() {
        UserDefaults.standard.removeObject(forKey: sessionsKey)
    }
}
