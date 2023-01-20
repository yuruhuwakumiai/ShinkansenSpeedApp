//
//  LocationManager.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2022/08/19.
//
import SwiftUI
import CoreLocation
import AVFoundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var location = CLLocation() // locationをObservableObjectにして使用するクラスでインスタンスする
    private let manager = CLLocationManager()
    private var audioPlayer:AVAudioPlayer? // 音声もManagerにしたい
    let audioPlayerManager = AudioPlayerManager()
    private var isOnce1 = false
    private var isOnce2 = false
    private var isOnce3 = false
    private var isOnce4 = false

    private func playSounds(soundfile: String, loop: Int, vol: Float) {
        let asset = NSDataAsset(name: soundfile)
        do {
            audioPlayer = try AVAudioPlayer(data: asset!.data, fileTypeHint: "mp3")
            audioPlayer?.numberOfLoops = loop
            audioPlayer?.volume = vol
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error")
        }
    }

    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 1
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        let speedSelectNum = Int(location.speed*3.6) // 速度で文字を表示させるための変数

        if speedSelectNum > 10 && isOnce1 == false {
            audioPlayerManager.playSound(sound: "出発進行", type: "mp3") // Managerクラスからインスタンスした
            isOnce1 = true
        }

        if speedSelectNum > 50 && isOnce2 == false {
            playSounds(soundfile: "５０キロ", loop: 0, vol: 10)
            isOnce2 = true
        }

        if speedSelectNum > 70 && isOnce3 == false {
            playSounds(soundfile: "７０キロ", loop: 0, vol: 10)
            isOnce3 = true
        }

        if speedSelectNum > 90 && isOnce4 == false {
            playSounds(soundfile: "最高速度接近", loop: 0, vol: 10)
            isOnce4 = true
        }
    }
}
