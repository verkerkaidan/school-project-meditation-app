//
//  MeditationSessionListView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 10/10/2024.
//

import SwiftUI

struct MeditationSessionListView: View {
    @ObservedObject private var viewModel = MeditationSessionViewModel()
    
    var body: some View {
        ScrollView {
            VStack (alignment: .trailing, spacing: 16) {
                Spacer()
                LazyVGrid(columns: [GridItem()], spacing: 16) {
                    ForEach(viewModel.sessions) { session in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Date: \(session.date, format: .dateTime)")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            Text("Duration: \(formatDuration(session.duration))")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            Text("Coins received: \(Int(5 + (2 * Int(session.duration/60))))")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                        }
                        .padding(10)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(10)
                        .padding(.vertical, 4)
                    }
                }
                Button {
                    viewModel.loadSessions()
                } label: {
                    Text("Clear Data")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                }
                .padding()
                .onAppear() {
                    viewModel.loadSessions()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

func formatDuration(_ duration: TimeInterval) -> String {
    let hours = Int(duration) / 3600
    let minutes = (Int(duration) % 3600) / 60
    let seconds = Int(duration) % 60
    
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

class MeditationSessionViewModel: ObservableObject {
    @Published var sessions: [MeditationSession] = []
    let manager = MeditationSessionManager()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func loadSessions() {
        sessions = manager.loadSessions()
    }
    
    func clearSessions() {
        manager.clearSessions()
    }
}

#Preview {
    MeditationSessionListView()
}
