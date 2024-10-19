//
//  AchievementsView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var currentUser: User

    let achievementList = [
        "A Calm Start": (description: "Meditate a total of 1 time.", target: 1),
        "Peaceful Moments": (description: "Meditate a total of 3 times.", target: 3),
        "Mindful Steps": (description: "Meditate a total of 5 times.", target: 5),
        "Tranquil Journey": (description: "Meditate a total of 10 times.", target: 10),
        "Serene Focus": (description: "Meditate a total of 25 times.", target: 25),
        "Harmony Within": (description: "Meditate a total of 50 times.", target: 50),
        "Zen Master": (description: "Meditate a total of 100 times.", target: 100),
        "Stillness Sage": (description: "Meditate a total of 200 times.", target: 200),
        "Mindful Guru": (description: "Meditate a total of 500 times.", target: 500),
        "Enlightened One": (description: "Meditate a total of 1000 times.", target: 1000)
    ]
    
    var body: some View {
        
    @State var achieved: Bool = false
        ZStack {
            Image(currentUser.equippedBackground.lowercased().replacingOccurrences(of: " ", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            ScrollView {
                Spacer(minLength: 100)
                Text("Achievements")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 0, y: 1)
                    .padding()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300))], spacing: 20) {
                    ForEach(achievementList.sorted { $0.value.target < $1.value.target }, id: \.key) { key, value in
                        let progress = Double(currentUser.meditationsCompleted) / Double(achievementList[key]?.target ?? 1)
                        let achieved = currentUser.achievements[key] ?? false
                        
                        AchievementCard(
                            achievementName: key,
                            achievementDescription: achievementList[key]?.description ?? "",
                            achieved: achieved,
                            progress: progress
                        )
                    }
                    .padding()
                }
                Spacer(minLength: 100)
            }
            .padding(.top, 30)
        }
    }
}

struct AchievementCard: View {
    var achievementName: String
    var achievementDescription: String
    var achieved: Bool
    var progress: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: achieved ? "trophy.fill" : "trophy")
                    .font(.largeTitle)
                    .foregroundColor(achieved ? .yellow : .white)
                Text(achievementName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            
            Text(achievementDescription)
                .font(.body)
                .foregroundColor(.white)
            
            ProgressView(value: progress)
                .accentColor(.yellow)
                .padding(.top, 5)
            
            if achieved {
                Text("Achievement Unlocked!")
                    .font(.subheadline)
                    .foregroundColor(.green)
                    .padding(.bottom)
            }
        }
        .padding(.horizontal)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

#Preview {
    AchievementsView()
        .environmentObject(User(id: UUID(), coins: 0, meditationsCompleted: 3, minutesMeditated: 0, achievements: ["A Calm Start" : true], unlockedHats: [], equippedHat: "", unlockedBackgrounds: [], equippedBackground: "defaultBackground", unlockedSoundtracks: [], equippedSoundtrack: ""))
}
