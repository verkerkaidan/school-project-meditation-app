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
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack() {
                TopBarView().environmentObject(currentUser)
                    .padding(-5)
                Spacer()
                Text("Store")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                    .padding(.horizontal)
                    .padding(.top, 30)
                
                ScrollView {
                    Button {
                        currentUser.unlockedCosmetics = []
                        UserManager.sharedUser.saveUser(currentUser)
                    } label: {
                        Image(.tophat)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
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
                                    StoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        
                        Text("[Second Section]")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(cosmeticManager.getAllHatCosmetics(), id: \.id) { cosmetic in
                                    StoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                        
                        Text("[Third Section]")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2, x: 0, y: 1)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: [GridItem()]) {
                                ForEach(cosmeticManager.getAllHatCosmetics(), id: \.id) { cosmetic in
                                    StoreItemView(item: cosmetic).environmentObject(currentUser)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    StoreView()
}
