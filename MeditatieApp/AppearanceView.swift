//
//  HistoryView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var currentUser: User
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    PetView().environmentObject(currentUser)
                    Text("Previous Meditation Sessions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                    Text("User Statistics")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                    Text("Meditation sessions completed: \(currentUser.meditationsCompleted)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                    Text("Minutes meditated: \(currentUser.minutesMeditated)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                    MeditationSessionListView()
                }
                .padding(.top, 150)
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    AppearanceView()
}
