//
//  IconImage.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

struct IconImage: View {
    let iconName: String

    init(_ iconName: String) {
        self.iconName = iconName
    }

    var body: some View {
        Image(iconName)
            .foregroundColor(Color.Image.Primary)
            .padding()
            .scaledToFit()
    }
}

// MARK: Preview
#Preview {
    VStack(spacing: 16) {
        IconImage("AppOfTheDay")
        IconImage("Reviews")
    }
    .padding()
}
