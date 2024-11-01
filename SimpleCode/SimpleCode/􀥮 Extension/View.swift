//
//  View.swift
//  iOS
//
//  Created by ShuZik on 27.03.2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import SwiftUI

extension View {
    func font(_ style: RegularFontStyle, _ size: Primitive.FontSize) -> some View {
        font(.customFMJfont(style, size))
    }

    func maskWave() -> some View {
        mask(WaveShape())
    }
}
