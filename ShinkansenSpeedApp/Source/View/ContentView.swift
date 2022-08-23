//
//  ContentView.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2022/08/18.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var manager = LocationManager()
    let screenWidth = UIScreen.main.bounds.width
    private let shinkansenSound = try!  AVAudioPlayer(data: NSDataAsset(name: "新幹線走行中")!.data)
    private func playSound(){
        shinkansenSound.play()
    }

    var body: some View {
        // 速度の計算(整数)
        let speed = Int(manager.location.speed*3.6)

        VStack {
            Text("げんざいのそくど")
                .h1Text(Color("main_red_color"))
            Spacer()
            switch speed {
            case 0..<20:
                Text("\(speed)")
                    .h1Text(.blue)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            case 21..<40:
                Text("\(speed)")
                    .h1Text(.yellow)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            case 41..<60:
                Text("\(speed)")
                    .h1Text(.orange)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            case 61..<80:
                Text("\(speed)")
                    .h1Text(.pink)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            case 80..<90:
                Text("\(speed)")
                    .h1Text(.green)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            case 91..<130:
                Text("\(speed)")
                    .h1Text(.red)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            default:
                Text("\(speed)")
                    .h1Text(.white)
                    .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                    .background(.black)
                    .cornerRadius(10)
            }
            Spacer()
            HeadLightView()
            Spacer()
            Text("しんかんせん")
                .h1Text(.white)
                .padding(.top,30)
                .frame(maxWidth: .infinity)
                .background(Color("main_red_color"))
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
        ContentView()
    }
}

// 別ファイルに記載
extension Text {
    func h1Text(_ foregroundColor: Color) -> Text {
        self
            .foregroundColor(foregroundColor)
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}
