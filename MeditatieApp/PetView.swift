//
//  PetView.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 08/10/2024.
//

import SwiftUI

struct PetView: View {
    @State private var eyesOpen = true
    @State private var timer: Timer?
    @EnvironmentObject var currentUser: User

    var body: some View {
        ZStack {
            Image(currentUser.equippedHat.lowercased().replacingOccurrences(of: " ", with: ""))
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 320)
//            if !currentUser.equippedHat.isEmpty {
//                let imageName = currentUser.equippedHat
//                Image(imageName.lowercased().replacingOccurrences(of: " ", with: ""))
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 250, height: 250)
//                    .offset(x: 0, y: -160)
//            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // Timer to toggle eyesOpen every second
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            toggleEyes()
        }
    }
    
    // Stop timer when the view disappears
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func toggleEyes() {
        eyesOpen.toggle()
    }
}

#Preview {
    PetView()
}
