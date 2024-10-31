//
//  ProfileView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 17/10/2024.
//

import SwiftUI
import Charts

struct ProfileView: View {
    @EnvironmentObject var currentUser: User
    @ObservedObject private var viewModel = MeditationSessionViewModel()

    var dailyDurations: [Date: TimeInterval] {
        print(viewModel.sessions)
        print(viewModel.sessions)
        let grouped = Dictionary(grouping: viewModel.sessions, by: { Calendar.current.startOfDay(for: $0.date) })
        print("Grouped Sessions by Date: \(grouped)")
        return grouped.mapValues { sessions in
            let totalDuration = sessions.reduce(0) { $0 + $1.duration }
            print("Date: \(Calendar.current.startOfDay(for: sessions.first!.date)), Total Duration: \(totalDuration)")
            return totalDuration
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("User Statistics")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                Text("Meditation sessions completed: \(currentUser.meditationsCompleted)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Daily Meditation Duration")
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                
                Chart {
                    ForEach(dailyDurations.keys.sorted(), id: \.self) { date in
                        if let duration = dailyDurations[date] {
                            BarMark(
                                x: .value("Date", date, unit: .day),
                                y: .value("Duration (minutes)", duration / 60)
                            )
                            .foregroundStyle(.blue)
                            .cornerRadius(4)
                        }
                    }
                }
                .frame(height: 300)
                .padding()
                .background(Color(.systemGray6).opacity(0.2))
                .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(.systemBlue))
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.loadSessions()
        }
    }
}

#Preview {
    ProfileView()
}
