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
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            toggleEyes()
        }
    }
    
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
