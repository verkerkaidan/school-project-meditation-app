//
//  ChangeAppearanceView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 17/10/2024.
//

import SwiftUI

struct ChangeAppearanceView: View {
    @EnvironmentObject var currentUser: User
    
    var body: some View {
        VStack {
            Text("Change your appearance")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 1)
            VStack(alignment: .leading) {
                Text("Hat")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(120))], spacing: 20) {
                    ForEach(currentUser.unlockedHats, id: \.self) { cosmetic in
                        Button {
                            currentUser.equipHat(cosmetic)
                        } label: {
                            VStack(spacing: 10) {
                                Image(cosmetic.lowercased().replacingOccurrences(of: " ", with: ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                Text(cosmetic)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemGray6))
                                    .shadow(radius: 5)
                                    .opacity(cosmetic == currentUser.equippedHat ? 0.8 : 0.4)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                Text("Background")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(120))], spacing: 20) {
                    ForEach(currentUser.unlockedBackgrounds, id: \.self) { cosmetic in
                        Button {
                            currentUser.equipBackground(cosmetic)
                            print(currentUser.unlockedBackgrounds)
                        } label: {
                            VStack(spacing: 10) {
                                Image(cosmetic.lowercased().replacingOccurrences(of: " ", with: ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                Text(cosmetic)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemGray6))
                                    .shadow(radius: 5)
                                    .opacity(cosmetic == currentUser.equippedBackground ? 0.75 : 0.5)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading) {
                Text("Background Music")
                    .font(.title2)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.fixed(120))], spacing: 20) {
                    ForEach(currentUser.unlockedSoundtracks, id: \.self) { cosmetic in
                        Button {
                            currentUser.equipSoundtrack(cosmetic)
                            print(currentUser.unlockedSoundtracks)
                        } label: {
                            VStack(spacing: 10) {
                                Image(systemName: "music.note")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                    .shadow(radius: 5)
                                Text(cosmetic)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(.systemGray6))
                                    .shadow(radius: 5)
                                    .opacity(cosmetic == currentUser.equippedSoundtrack ? 0.75 : 0.5)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ChangeAppearanceView()
}
