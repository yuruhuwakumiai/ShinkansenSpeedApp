//
//  ContentView.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2022/08/18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = LocationManager()

    var body: some View {
        ZStack {
            VStack {
                TitleTextView()
                Spacer()
                SpeedMeterView()
                Spacer()
                BottomBarView()
            }
        }
    }

    struct TitleTextView: View {
        var body: some View {
            Text("げんさいのそくど")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .foregroundColor(Color("main_red_color"))
        }
    }

    struct SpeedMeterView: View {
        @ObservedObject var manager = LocationManager()
        var body: some View {
            ZStack {
                let speed = manager.location.speed
                let latitude = $manager.location.wrappedValue.coordinate.latitude
                let longitude = $manager.location.wrappedValue.coordinate.longitude
                Rectangle()
                    .fill(Color.black)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width/1.8, height: UIScreen.main.bounds.width/1.5 )
                Text("\(speed)")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }
        }
    }

    struct BottomBarView: View {
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color("main_red_color"))
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/6)
                Text("しんかんせん")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
