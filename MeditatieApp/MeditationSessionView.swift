//
//  MeditationSessionView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct MeditationSessionView: View {
    @State var timeRemaining: Double
    @State var minutesMeditated: Double = 0
    @State var timerIsActive = false
    @EnvironmentObject var currentUser: User
    @ObservedObject private var viewModel = MeditationSessionViewModel()
    

    var body: some View {
        
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Text("Time Remaining in Session:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                    .padding()
                
                if timeRemaining > 0 {
                    Text(formatTime(seconds: Int(timeRemaining)))
                        .font(.largeTitle)
                        .fontWeight(.bold) // Semi-bold for the timer text
                        .foregroundColor(.yellow) // Yellow color for a warm, sunset-like feel
                        .shadow(color: .black, radius: 2, x: 0, y: 1) // Consistent shadow for readability
                } else {
                    Text("Session Over")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.red) // Red color to indicate session end
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                        .padding()
                }
                
                PetView()
                    .offset(y: 100)
                Button {
                    timeRemaining = 3
                } label: {
                    Text("Skip Timer")
                }
            }
        }
        .onAppear {
            minutesMeditated = timeRemaining/60
            if !timerIsActive {
                startTimer()
            }
        }
    }

    func startTimer() {
        timerIsActive = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                currentUser.updateCoins(by: 5 + (2 * Int(minutesMeditated)))
                currentUser.updateMeditationsCompleted(by: 1)
                currentUser.updateMinutesMeditated(by: Int(minutesMeditated))
                viewModel.manager.saveSession(MeditationSession(duration: minutesMeditated * 60))
                UserManager().saveUser(currentUser)
                timer.invalidate()
            }
        }
    }
    
    func formatTime(seconds: Int) -> String {
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let seconds = seconds % 60
            
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }


#Preview {
    MeditationSessionView(timeRemaining: 60)
}
