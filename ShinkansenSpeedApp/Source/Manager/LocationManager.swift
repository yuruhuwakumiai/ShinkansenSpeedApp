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
    @Published var location = CLLocation()
    private let manager = CLLocationManager()
    let audioPlayerManager = AudioPlayerManager()

    private var audioPlayedForSpeed = [Int: Bool]()

    private let speedToSoundMapping: [(speed: Int, soundfile: String)] = [
        (10, "出発進行"),
        (50, "５０キロ"),
        (70, "７０キロ"),
        (90, "最高速度接近")
    ]

    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 1
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!
        let speedSelectNum = Int(location.speed*3.6)

        for mapping in speedToSoundMapping {
            if speedSelectNum > mapping.speed, audioPlayedForSpeed[mapping.speed] == nil {
                audioPlayerManager.playSound(sound: mapping.soundfile, type: "mp3")
                audioPlayedForSpeed[mapping.speed] = true
            }
        }
    }
}
