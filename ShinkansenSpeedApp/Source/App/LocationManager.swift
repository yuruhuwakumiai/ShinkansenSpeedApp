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
    var audioPlayer:AVAudioPlayer?

    func playSounds(soundfile: String, loop: Int, vol: Float) {
        let asset = NSDataAsset(name: soundfile)
        do{
            audioPlayer = try AVAudioPlayer(data: asset!.data, fileTypeHint: "mp3")
            audioPlayer?.numberOfLoops = loop
            audioPlayer?.volume = vol
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }catch {
            print("Error")
        }
    }
    private var isOnce = false

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
            isOnce = true
            playSounds(soundfile: "新幹線走行中", loop: -1, vol: 3)
        }
    }
}
