//
//  SystemIconLabel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct SystemIconText: View {
    let image: String
    let label: String

    init(_ image: String, _ label: String) {
        self.image = image
        self.label = label
    }
    
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(label)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.gray)
        .font(.subheadline)
    }
}

#Preview {
    SystemIconText("speedometer", "500 miles")
        .padding()
}
