//
//  TopBarView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct TopBarView: View {
    @EnvironmentObject var currentUser: User
    @State var isHistoryPresented: Bool = false
    @State var isProfilePresented: Bool = false

    var body: some View {
        HStack {
            // Profile icon on the left
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .onTapGesture {
                    isProfilePresented.toggle()
                }
            Spacer()
            
            // Coins or other items on the right
            HStack(spacing: 20) {
                // Coins
                HStack {
                    Image(systemName: "leaf.circle")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("\(currentUser.coins)")
                        .font(.headline)
                }
                
                // You can add more items here, like notifications or other icons
                Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                    .onTapGesture {
                        isHistoryPresented.toggle()
                    }
            }
        }
        .padding(.top, 50)
        .sheet(isPresented: $isHistoryPresented) {
            MeditationSessionListView()
        }
        .sheet(isPresented: $isProfilePresented) {
            ProfileView().environmentObject(currentUser)
        }
    }
}


#Preview {
    TopBarView()
}
