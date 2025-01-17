//
//  AccsentLabel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct AccsentText: View {
    let label: String
    
    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.green)
    }
}

#Preview {
    AccsentText("500 miles")
        .padding()
}
