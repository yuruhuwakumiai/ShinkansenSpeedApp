//
//  HomeView.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2022/08/18.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    @ObservedObject var manager = LocationManager()
    let audioPlayerManager = AudioPlayerManager()
    let screenWidth = UIScreen.main.bounds.width
//    private let shinkansenSound = try!  AVAudioPlayer(data: NSDataAsset(name: "新幹線走行中")!.data)
    @State var speedToSoundMapping: [(speed: Int, soundfile: String, played: Bool)] = [
        (10, "R350警報音", false),
        (50, "R300警報音", false),
        (70, "R250警報", false),
        (90, "最高速度接近", false)
    ]


    var body: some View {
        VStack {
            Text("げんざいのそくど")
                .h1Text(Color("main_red_color"))
            Spacer()
            Text("\(manager.speed)km")
                .h1Text(textColor)
                .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                .background(.black)
                .cornerRadius(10)
            Spacer()
            HeadLightView()
            Spacer()
            Text("しんかんせん")
                .h1Text(.white)
                .padding(.top,30)
                .frame(maxWidth: .infinity)
                .background(Color("main_red_color"))
        }
        // MARK: んー、再生しない〜
        .onAppear {
            playSound()
        }
        .onReceive(manager.$speed) { _ in
            playSound()
        }
    }

    private var textColor: Color {
        switch manager.speed {
        case 0..<20:
            return .blue
        case 20..<40:
            return .yellow
        case 40..<60:
            return .orange
        case 60..<80:
            return .pink
        case 80..<90:
            return .green
        case 90..<130:
            return .red
        default:
            return .white
        }
    }

    func playSound() {
        for index in speedToSoundMapping.indices {
            if manager.speed >= speedToSoundMapping[index].speed && manager.speed < (index + 1 < speedToSoundMapping.count ? speedToSoundMapping[index + 1].speed : Int.max) && !speedToSoundMapping[index].played {
                audioPlayerManager.playSound(sound: speedToSoundMapping[index].soundfile, type: "mp3")
                speedToSoundMapping[index].played = true
            }
        }
    }


    struct HeadLightView: View {
        var body: some View {
            HStack(spacing:150) {
                Image("ライト左")
                Image("ライト右")
            }
        }
    }
}

struct ContentView_Previews:  PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
