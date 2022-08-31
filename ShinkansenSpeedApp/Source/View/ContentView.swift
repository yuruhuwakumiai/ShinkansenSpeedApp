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
    
    @State var textColor: Color = .black
    @State var speed: Int

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
            
            Button(action: {
//                speed = Int.random(in: 0...130)
                setSpeed()
            }) {
                Text("speed変更")
            }
        }
        .onAppear {
            setSpeed()
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
    
    private func setSpeed() {
        speed = Int(manager.location.speed*3.6)
        switch speed {
        case 0..<20:
            self.textColor = .blue
        case 21..<40:
            self.textColor = .yellow
        case 41..<60:
            self.textColor = .orange
        case 61..<80:
            self.textColor = .pink
        case 80..<90:
            self.textColor = .green
        case 91..<130:
            self.textColor = .red
        default:
            self.textColor = .white
        }
    }
}

//struct ContentView_Previews:  PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

// 別ファイルに記載
extension Text {
    func h1Text(_ foregroundColor: Color) -> Text {
        self
            .foregroundColor(foregroundColor)
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}
