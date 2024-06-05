//
//  Text.swift
//  SimpleCode
//
//  Created by ShuZik on 10.05.2024.
//

import SwiftUI

struct ImgeTextView: View {
    
    let text: String
    
    var body: some View {
        label
            .overlay(image)
            .mask(label)
    }
    
    var label: some View {
        Text(text)
            .font(.system(size: 100))
            .fontWeight(.black)
    }
    
    var image: some View {
        Image("Sky")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    ImgeTextView(text: "Hello")
}
