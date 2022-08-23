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
    private let manager = CLLocationManager()
    @Published var location = CLLocation()
    private let sound: AVAudioPlayer = try! AVAudioPlayer(data: NSDataAsset(name:"新幹線走行中")!.data)
    private var isOnce = false

    private func playSound() {
        sound.currentTime = 0.0
        sound.numberOfLoops = -1
        sound.play()
    }

    override init() {
        super.init()

        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 2
        self.manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                           didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last!

        if location.speed > 5 && isOnce == false {
            playSound()
            isOnce = true
        }
    }
}
