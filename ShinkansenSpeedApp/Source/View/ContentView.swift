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
        let speed = manager.location.speed
        let latetude = $manager.location.wrappedValue.coordinate.latitude
              let longitude = $manager.location.wrappedValue.coordinate.longitude
        Text("\(speed)")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
