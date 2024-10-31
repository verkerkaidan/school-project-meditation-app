//
//  StoreView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject var currentUser: User
    let cosmeticManager = CosmeticManager()
    
    var body: some View {
        
        ZStack {
            Image(currentUser.equippedBackground.lowercased().replacingOccurrences(of: " ", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            VStack() {
                TopBarView().environmentObject(currentUser)
                Spacer()
                Text("Store")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                    .padding(.horizontal)
                    .padding(.top, 30)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem()]) {
                        Text("Hats")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(cosmeticManager.getAllHatCosmetics(), id: \.id) { cosmetic in
                                    HatStoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        
                        Text("Backgrounds")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(cosmeticManager.getAllBackgroundCosmetics(), id: \.id) { cosmetic in
                                    BackgroundStoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        
                        Text("Soundtracks")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(cosmeticManager.getAllSoundtrackCosmetics(), id: \.id) { cosmetic in
                                    SoundtrackStoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        
//                        Button {
//                            currentUser.unlockedHats = []
//                            currentUser.unlockedBackgrounds = []
//                            currentUser.unlockedSoundtracks = []
//                            UserManager.sharedUser.saveUser(currentUser)
//                        } label: {
//                            Text("Reset Unlocks (Dev)")
//                                .font(.headline)
//                                .foregroundColor(.blue)
//                                .padding(10)
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(8)
//                        }
                        
                    }
                }
                Spacer(minLength: 100)
            }
        }
    }
}

#Preview {
    StoreView()
}
