//
//  SoundManager.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2023/01/20.
//

import AVFoundation

class AudioPlayerManager: NSObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?

    func playSound(sound: String, type: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: type) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

