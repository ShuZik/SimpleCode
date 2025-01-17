//
//  PrimaryLabel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct PrimaryText: View {
    let label: String
    
    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .font(.title3)
            .bold()
    }
}

#Preview {
    PrimaryText("500 miles")
        .padding()
}

