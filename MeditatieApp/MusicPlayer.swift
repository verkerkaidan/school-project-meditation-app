//
//  MusicPlayer.swift
//  MeditatieApp
//
//  Created by Aidan Verkerk on 17/10/2024.
//

import Foundation
import AVFoundation

class MusicPlayer: ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playMusic(fileName: String) {
        if let path = Bundle.main.path(forResource: fileName.lowercased().replacingOccurrences(of: " ", with: ""), ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                print("Playing music")
                print(fileName + ".mp3")
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        } else {
            print("Music file not found. \(fileName)")
        }
    }

    func stopMusic() {
        audioPlayer?.stop()
    }
}
