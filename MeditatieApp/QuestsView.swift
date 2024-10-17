//
//  QuestView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct QuestsView: View {
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Daily Quests")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                        .padding()
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Complete 3 meditation sessions")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 2, total: 3)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Meditate for 50 minutes")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 30, total: 50)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Complete 1 achievement")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 1, total: 1)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
                .padding()
                VStack(alignment: .leading, spacing: 16) {
                    Text("Weekly Quests")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2, x: 0, y: 1)
                        .padding()
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Complete 10 meditation sessions")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 2, total: 10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Meditate for 300 minutes")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 80, total: 300)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Complete 3 achievements")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2, x: 0, y: 1)
                            ProgressView(value: 1, total: 3)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

#Preview {
    QuestsView()
}
