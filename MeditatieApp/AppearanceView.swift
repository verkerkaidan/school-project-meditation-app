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
                    ForEach(currentUser.unlockedCosmetics, id: \.self) { cosmetic in
                        Button {
                            currentUser.equipCosmetic(cosmetic)
                        } label: {
                            VStack(spacing: 10) {
                                Image(cosmetic.lowercased().replacingOccurrences(of: " ", with: ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                    .shadow(radius: 5) // Add a shadow for depth
                                Text(cosmetic)
                                    .font(.headline) // Make the text larger and more prominent
                                    .foregroundColor(.primary)
                            }
                            .padding() // Add padding inside the button
                            .background(
                                RoundedRectangle(cornerRadius: 16) // Make the button background rounded
                                    .fill(Color(.systemGray6)) // Use a light background color
                                    .shadow(radius: 5) // Add a shadow to the button
                            )
                        }
                        .buttonStyle(PlainButtonStyle()) // Use a plain button style to prevent default button appearance
                        .padding(.vertical, 5) // Add vertical padding between buttons
                    }
                    Spacer()
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
