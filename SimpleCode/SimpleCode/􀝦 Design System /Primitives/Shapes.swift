//
//  Shapes.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

struct WaveShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()
		
		// Set the wave's amplitude to half of the rectangle's height
		let amplitude = rect.height / 2

		// Start at the bottom left corner
		path.move(to: CGPoint(x: rect.minX, y: rect.maxY))

		// Move up to the starting point of the wave, a quarter way up the rect
		path.addLine(to: CGPoint(x: rect.minX, y: amplitude / 2))

		// Create a smooth wave
		// First control point for the cubic Bezier curve, pulling the curve up
		let controlPoint1 = CGPoint(x: rect.minX + rect.width * 0.25, y: rect.minY - amplitude)
		let controlPoint2 = CGPoint(x: rect.minX + rect.width * 0.75, y: rect.maxY + amplitude)
		let endPoint = CGPoint(x: rect.maxX, y: amplitude)

		// Draw the cubic Bezier curve for the wave
		path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)

		// Finish the shape by returning to the bottom right corner
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

		// Close the path to complete the shape
		path.closeSubpath()

		return path
	}
}

