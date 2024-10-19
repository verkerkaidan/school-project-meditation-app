//
//  ProfileView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 17/10/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var currentUser: User
    
    var body: some View {
        Text("User Statistics")
            .font(.title)
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
            .shadow(color: .black, radius: 2, x: 0, y: 1)    }
}

#Preview {
    ProfileView()
}
