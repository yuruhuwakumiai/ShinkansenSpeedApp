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
    let screenWidth = UIScreen.main.bounds.width
    private let shinkansenSound = try!  AVAudioPlayer(data: NSDataAsset(name: "新幹線走行中")!.data)

    var body: some View {
        VStack {
            Text("げんざいのそくど")
                .h1Text(Color("main_red_color"))
            Spacer()
            Text("\(speed)km")
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
        .onAppear {
            playSound()
        }
    }

    private var speed: Int {
        Int(manager.location.speed*3.6)
    }

    private var textColor: Color {
        switch speed {
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

    private func playSound() {
        shinkansenSound.play()
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
