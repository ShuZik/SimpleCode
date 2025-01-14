//
//  SquidGameView.swift
//  SimpleCode
//
//  Created by ShuZik on 14.01.2025.
//

import SwiftUI

struct SquidGameView: View {
    @State private var selectedTab: Int = 0
    
    private let tabIcons = ["cross.fill", "square.fill", "circle.fill", "triangle.fill"]
    private let tabImages = ["GBoss", "GSquare", "GCircle", "GTriangle"]
    
    var body: some View {
        VStack {
            LogoView(imageName: "GLogo")
                .padding(.top, 40)

            Spacer()

            AnimatedTabView(tabImages: tabImages, selectedTab: $selectedTab)
                .frame(height: 240)

            Spacer()

            TabBar(tabIcons: tabIcons, selectedTab: $selectedTab)
                .padding(.bottom, 24)
        }
        .background(Color.gray.opacity(0.9).edgesIgnoringSafeArea(.all))
    }
}

struct LogoView: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 150)
    }
}

struct AnimatedTabView: View {
    let tabImages: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<tabImages.count, id: \.self) { index in
                Image(tabImages[index])
                    .resizable()
                    .scaledToFit()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.4), value: selectedTab)
    }
}

struct TabBar: View {
    let tabIcons: [String]
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            ForEach(0..<tabIcons.count, id: \.self) { index in
                TabBarButton(iconName: tabIcons[index], isSelected: selectedTab == index) {
                    withAnimation {
                        selectedTab = index
                    }
                }
            }
        }
        .background(Color.black.opacity(0.8))
        .clipShape(Capsule())
    }
}

struct TabBarButton: View {
    let iconName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isSelected ? Color.Base.Pink : Color.Base.Gray)
                .padding()
        }
    }
}

#Preview {
    SquidGameView()
}
