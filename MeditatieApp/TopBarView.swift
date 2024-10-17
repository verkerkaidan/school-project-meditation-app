//
//  TopBarView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct TopBarView: View {
    @EnvironmentObject var currentUser: User

    var body: some View {        
        HStack {
            // Profile icon on the left
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
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
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
            }
        }
    }
}


#Preview {
    TopBarView()
}
