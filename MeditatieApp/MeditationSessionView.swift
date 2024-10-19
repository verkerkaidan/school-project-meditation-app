//
//  MeditationSessionView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct MeditationSessionView: View {
    @StateObject var musicPlayer = MusicPlayer()
    @State var timeRemaining: Double
    @State var minutesMeditated: Double = 0
    @State var timerIsActive = false
    @EnvironmentObject var currentUser: User
    @ObservedObject private var viewModel = MeditationSessionViewModel()
    @State var showAlert = false
    @Environment(\.scenePhase) var scenePhase // Detecting app phase changes
    @State var sessionCompleted = false
    @State var timerStarted = false // Tracks if the timer has already started
    
    
    var body: some View {
        
        ZStack {
            Image(currentUser.equippedBackground.lowercased().replacingOccurrences(of: " ", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            VStack {
                TopBarView().environmentObject(currentUser)
                Spacer()
                Text("Time Remaining in Session:")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                    .padding()
                
                if timeRemaining >= 0 {
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
                Spacer()
                
                PetView()
                Button {
                    timeRemaining = 3
                } label: {
                    Text("Skip Timer")
                }
                Spacer(minLength: 100)
            }
        }
        .onDisappear() {
            endSessionPrematurely()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Session Over"),
                message: Text("Congratulations on completing your session! \(5 + (2 * Int(minutesMeditated))) coins have been added to your account."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            if !timerStarted {
                minutesMeditated = timeRemaining/60
                startTimer()
                timerStarted = true
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase != .active {
                endSessionPrematurely()
            }
        }
    }
    
    func startTimer() {
        timerIsActive = true
        musicPlayer.playMusic(fileName: currentUser.equippedSoundtrack)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                sessionCompleted = true
                endSessionSuccessfully()
                timer.invalidate()
            }
        }
    }
    
    func endSessionSuccessfully() {
        if sessionCompleted {
            currentUser.updateCoins(by: 5 + (2 * Int(minutesMeditated)))
            currentUser.updateMeditationsCompleted(by: 1)
            currentUser.updateMinutesMeditated(by: Int(minutesMeditated))
            viewModel.manager.saveSession(MeditationSession(duration: minutesMeditated * 60))
            UserManager().saveUser(currentUser)
            showAlert = true
        }
        musicPlayer.stopMusic()
        timerIsActive = false
    }
    
    func endSessionPrematurely() {
        musicPlayer.stopMusic()
        timerIsActive = false
        timeRemaining = 0
        sessionCompleted = false
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
