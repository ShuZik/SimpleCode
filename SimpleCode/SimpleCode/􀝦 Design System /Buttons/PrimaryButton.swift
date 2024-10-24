//
//  PrimaryButton.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let action: () -> Void

    @State private var isPressed = false

    init(_ text: String, _ action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(text) // Should be Primary label but we have UI bug
                .lineLimit(1)
                .padding(.vertical, Primitive.Padding.Button.Vertical)
                .padding(.horizontal, Primitive.Padding.Button.Horizontal)
                .font(.bold, .H17)
                .frame(maxWidth: .infinity)
                .foregroundColor(.Button.Primary)
        }
        .frame(height: 50)
        .background(Color.Base.Primary)
        .clipShape(RoundedRectangle(cornerRadius: Primitive.CornerRadius.Button))
        .scaleEffect(isPressed ? 0.97 : 1)
        .brightness(isPressed ? -0.05 : 0)
        .animation(.linear(duration: 0.2), value: isPressed)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

// MARK: Preview

#Preview {
    VStack(spacing: 16) {
        PrimaryButton("Primary Theme.Main") {}
    }
    .padding()
}
