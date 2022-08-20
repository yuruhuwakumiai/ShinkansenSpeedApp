//
//  ContentView.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2022/08/18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = LocationManager()
    let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        // 速度の計算
        let speed = manager.location.speed*3.6
        let floorSpeed = floor(speed*10)/10

        VStack {
            Text("げんざいのそくど")
                .h1Text(Color("main_red_color"))
            Spacer()
            Text("\(floorSpeed)")
                .h1Text(.white)
                .frame(width: screenWidth/1.8, height: screenWidth/1.5)
                .background(.black)
                .cornerRadius(10)
            Spacer()
            HeadLightView()
            Spacer()
            Text("しんかんせん")
                .h1Text(.white)
                .padding(.top,30)
                .frame(maxWidth: screenWidth)
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

struct ContentView_Previews: PreviewProvider {
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
