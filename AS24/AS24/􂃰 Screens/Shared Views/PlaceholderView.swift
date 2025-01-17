//
//  PlaceholderImageView.swift
//  AS24
//
//  Created by ShuZik on 17.01.2025.
//

import SwiftUI

struct PlaceholderView: View {
    
    var body: some View {
        Image("PlaceholderImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
    }
}
