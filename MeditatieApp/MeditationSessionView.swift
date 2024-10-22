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
    
    @EnvironmentObject var currentUser: User
    @ObservedObject private var viewModel = MeditationSessionViewModel()
    @State var showAlert = false
    @State var showInvalidSessionAlert = false
    @Environment(\.scenePhase) var scenePhase
    @State var sessionCompleted = false
    @State var timerStarted = false
    @State private var navigateToHome: Bool = false
    @State private var meditationTimer: Timer?
    @State private var isSessionPrematurelyEnded = false
    
    
    var body: some View {
        NavigationStack {
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
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                    } else {
                        Text("Session Over")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
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
                    
                    NavigationLink(destination: MeditationSetupView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    Spacer(minLength: 100)
                }
            }
            .onDisappear() {
                if !isSessionPrematurelyEnded && !sessionCompleted {
                    endSessionPrematurely()
                }
            }
            .onAppear {
                if !timerStarted {
                    minutesMeditated = timeRemaining/60
                    startTimer()
                }
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase != .active {
                    if !isSessionPrematurelyEnded && !sessionCompleted {
                        endSessionPrematurely()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EmptyView()
                }
            }
            .alert(isPresented: .constant(showAlert || showInvalidSessionAlert)) {
                if showAlert {
                    return Alert(
                        title: Text("Session Over"),
                        message: Text("Congratulations on completing your session! \(5 + (2 * Int(minutesMeditated))) coins have been added to your account."),
                        dismissButton: .default(Text("OK"), action: {
                            navigateToHome = true
                            showAlert = false
                        })
                    )
                } else if showInvalidSessionAlert {
                    return Alert(
                        title: Text("Session Interrupted"),
                        message: Text("Looks like you stopped meditating there, no rewards were granted."),
                        dismissButton: .default(Text("OK"), action: {
                            navigateToHome = true
                            showInvalidSessionAlert = false
                            
                        })
                    )
                } else {
                    return Alert(title: Text("Unknown"))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func startTimer() {
        timerStarted = true
        
        musicPlayer.playMusic(fileName: currentUser.equippedSoundtrack)
        meditationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
                print(timeRemaining)
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
        }
        showAlert = true
        print(showAlert)
        musicPlayer.stopMusic()
        meditationTimer?.invalidate()
    }
    
    func endSessionPrematurely() {
        guard !isSessionPrematurelyEnded else { return }
        isSessionPrematurelyEnded = true
        musicPlayer.stopMusic()
        
        sessionCompleted = false
        meditationTimer?.invalidate()
        showInvalidSessionAlert = true
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
