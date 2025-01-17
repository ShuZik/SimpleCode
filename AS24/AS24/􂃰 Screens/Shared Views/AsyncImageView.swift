//
//  AsyncImageView.swift
//  AS24
//
//  Created by ShuZik on 17.01.2025.
//

import SwiftUI

struct AsyncImageView: View {
    let urlString: String

    var body: some View {
        if let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    LoadingPlaceholder()
                case .success(let img):
                    img.resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                case .failure:
                    PlaceholderView()
                @unknown default:
                    PlaceholderView()
                }
            }
        } else {
            PlaceholderView()
        }
    }

    private func LoadingPlaceholder() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.gray)
        }
    }
}
