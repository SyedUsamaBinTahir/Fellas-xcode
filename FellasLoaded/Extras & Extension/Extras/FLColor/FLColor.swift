//
//  FLColor.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let appColor = Color("app-color")
    let appGrayColor = Color("app-gray-color")
    let textGrayColor = Color("text-gray-color")
    let tabbarColor = Color("tabbar-color")
}
