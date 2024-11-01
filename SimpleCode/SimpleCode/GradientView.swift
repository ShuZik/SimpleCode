//
//  GradientView.swift
//  SimpleCode
//
//  Created by ShuZik on 05.06.2024.
//

import SwiftUI

struct GradientView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            // Основной градиентный фон
            LinearGradient(
                gradient: Gradient(colors: colorScheme == .dark ? darkThemeColors() : lightThemeColors()),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            RadialGradient(
                gradient: Gradient(colors: colorScheme == .dark ? [Color(red: 0.3, green: 0.3, blue: 1.0), Color.clear] : [Color(red: 1.0, green: 0.3, blue: 0.3), Color.clear]),
                center: .center,
                startRadius: 50,
                endRadius: 400
            )
            .blendMode(.overlay)
            .edgesIgnoringSafeArea(.all)
            
            ForEach(0..<6) { index in
                AnimatedCircle(index: index, isDarkMode: colorScheme == .dark)
            }

            Color.clear
                .background(BlurView(style: .systemUltraThinMaterial))
                .edgesIgnoringSafeArea(.all)
        }
    }

    private func lightThemeColors() -> [Color] {
        return [Color(red: 0.8, green: 0.0, blue: 0.8), Color(red: 0.0, green: 0.5, blue: 1.0), Color(red: 0.0, green: 0.7, blue: 1.8)]
    }

    private func darkThemeColors() -> [Color] {
        return [Color(red: 0.2, green: 0.0, blue: 0.4), Color(red: 0.0, green: 0.2, blue: 0.5), Color(red: 0.0, green: 0.4, blue: 0.9)]
    }
}

struct AnimatedCircle: View {
    @State private var position: CGPoint
    private let speed: Double = Double.random(in: 25.0...50.0)
    private let color: Color

    init(index: Int, isDarkMode: Bool) {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let xPosition = CGFloat(index % 3) * (screenWidth / 3) + (screenWidth / 6)
        let yPosition = CGFloat(index / 3) * (screenHeight / 2) + (screenHeight / 4)
        self._position = State(initialValue: CGPoint(x: xPosition, y: yPosition))
        
        self.color = isDarkMode ?
            Color(red: .random(in: 0.0...0.5), green: .random(in: 0.0...0.5), blue: .random(in: 0.0...0.5)) :
            Color(red: .random(in: 0.5...1.0), green: .random(in: 0.5...1.0), blue: .random(in: 0.5...1.0))
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: CGFloat.random(in: 300...500), height: CGFloat.random(in: 300...500))
            .position(position)
            .blur(radius: 10)
            .blendMode(.overlay)
            .onAppear {
                moveCircle()
            }
            .animation(Animation.linear(duration: speed).repeatForever(autoreverses: true), value: position)
    }
    
    private func moveCircle() {
        position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

#Preview {
    GradientView()
}
