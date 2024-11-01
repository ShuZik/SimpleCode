//
//  PrimaryLabel.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

struct PrimaryLabel: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .foregroundColor(.Label.Primary)
            .font(.bold, .H17)
    }
}

// MARK: Preview

#Preview {
    VStack {
        PrimaryLabel("Primary Main Label")
    }
}
