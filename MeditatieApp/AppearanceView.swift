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
            Image(currentUser.equippedBackground.lowercased().replacingOccurrences(of: " ", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    PetView().environmentObject(currentUser)
                    ChangeAppearanceView().environmentObject(currentUser)
                    Spacer()
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
