//
//  SecondaryLabel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct SecondaryText: View {
    let label: String
    
    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .foregroundColor(.gray)
    }
}

#Preview {
    SecondaryText("500 miles")
        .padding()
}

