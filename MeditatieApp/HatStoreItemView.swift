//
//  StoreItemView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI
import UIKit

struct HatStoreItemView: View {
    var item: HatCosmetic
    @State var showAlert: Bool = false
    @EnvironmentObject var currentUser: User

    var body: some View {
        VStack {
            Text(item.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 2, x: 0, y: 1)
            HStack {
                Image(systemName: "leaf.circle.fill")
                    .padding(.trailing, -8)
                Text(item.price.formatted())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                item.imageResource!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
            }
            if !currentUser.unlockedHats.contains(item.name) {
                Button {
                    if currentUser.coins >= item.price {
                        currentUser.unlockHat(item.name)
                        currentUser.updateCoins(by: -item.price)
                    } else {
                        showAlert.toggle()
                    }
                } label: {
                    Text("Purchase")
                        .padding()
                        .background(Color.teal)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Not Enough Coins"),
                        message: Text("You need \(item.price - currentUser.coins) more coins to purchase this item."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            } else {
                Button {
                    
                } label: {
                    Text("Already Owned")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                        .disabled(true)
                }
            }
        }
    }
}
