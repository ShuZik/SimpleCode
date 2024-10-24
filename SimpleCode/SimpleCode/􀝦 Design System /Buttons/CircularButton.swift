//
//  CircularButton.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

struct CircularButton: View {
    var action: () -> Void
    var image: String
    
    init(_ image: String, _ action: @escaping () -> Void) {
        self.action = action
        self.image = image
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // Optional: Adds a border effect
        }
    }
}


#Preview {
    CircularButton("plus") {
        print("CircularButton press")
    }
}
