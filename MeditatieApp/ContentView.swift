//
//  ContentView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var currentUser = UserManager.sharedUser.loadUser()
    
    var body: some View {
        VStack {
            TabView {
                AppearanceView().environmentObject(currentUser)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Appearance", systemImage: "cat")
                    }
                
                AchievementsView().environmentObject(currentUser)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Achievements", systemImage: "trophy")
                    }
                
                MeditationSetupView().environmentObject(currentUser)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Meditate", systemImage: "brain.head.profile")
                    }
                
                QuestsView()
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Quests", systemImage: "flag")
                    }
                
                StoreView().environmentObject(currentUser)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .tabItem {
                        Label("Store", systemImage: "briefcase")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
