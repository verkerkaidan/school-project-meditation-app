//
//  MeditationSetupView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct MeditationSetupView: View {
    @State var meditationTimeInSeconds: Double = 600
    @State var inputText: String = ""
    @EnvironmentObject var currentUser: User
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(currentUser.equippedBackground.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                VStack {
                    Text("How long would you like to meditate for?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                        .padding()
                    VStack {
                        Slider(value: $meditationTimeInSeconds, in: 60...7200, step: 60)
                            .frame(width: 350, height: 50)
                        
                        Text("Time: \(Int(meditationTimeInSeconds) / 60) minutes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                        Text("You'll get \(Int(5 + (2 * Int(meditationTimeInSeconds/60)))) coins for this.")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding()
                    }
                    NavigationLink(destination: MeditationSessionView(timeRemaining: meditationTimeInSeconds).environmentObject(currentUser)) {
                        Text("Start Meditation")
                            .font(.title)
                            .padding()
                            .background(Color(UIColor.systemTeal))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(radius: 10)
                    }
                }
                .onChange(of: inputText) { oldValue, newValue in
                    if let value = Double(newValue) {
                        meditationTimeInSeconds = value
                    }
                }
            }
        }
    }
}

#Preview {
    MeditationSetupView()
}
