//
//  Fonts.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

enum RegularFontStyle: String {
    case light = "SFProText-Light"
    case regular = "SFProText-Regular"
    case medium = "SFProText-Medium"
    case semibold = "SFProText-Semibold"
    case bold = "SFProText-Bold"
    case heavy = "SFProText-Heavy"

    case special_regular = "Canela-Regular"
    case special_italic = "Canela-RegularItalic"
    case special_text = "CanelaText-Regular"
}

extension Font {
    static func customFMJfont(_ style: RegularFontStyle, _ size: Primitive.FontSize) -> Font {
        .custom(style.rawValue, size: size.rawValue)
    }
}
