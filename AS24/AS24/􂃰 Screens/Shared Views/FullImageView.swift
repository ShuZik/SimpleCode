//
//  FullImageView.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct FullImageView: View {
    let images: [CarImageModel]
    let height: CGFloat

    init(_ images: [CarImageModel]?, _ imageHeight: CGFloat = 300) {
        self.images = images?.isEmpty == false ? images! : [CarImageModel(url: "placeholder_url")]
        self.height = imageHeight
    }

    var body: some View {
        Group {
            TabView {
                ForEach(Array(images.enumerated()), id: \.offset) { index, image in
                    AsyncImageView(urlString: image.url)
                        .contentShape(Rectangle())
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: height)
        }
    }
}
