//
//  FontExtension.swift
//  ShinkansenSpeedApp
//
//  Created by 橋元雄太郎 on 2023/03/12.
//

import Foundation
import SwiftUI

extension Text {
    func h1Text(_ foregroundColor: Color) -> Text {
        self
            .foregroundColor(foregroundColor)
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}
