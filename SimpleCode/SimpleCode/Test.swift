//
//  Test.swift
//  SimpleCode
//
//  Created by ShuZik on 11.03.2025.
//

import SwiftUI

struct MirroredSShape: Shape {
    let points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard points.count > 2 else { return path }
        
        path.move(to: points[0])
        path.addLine(to: points[1])
        path.addQuadCurve(to: points[3], control: points[2])
        path.addQuadCurve(to: points[5], control: points[4])
        path.addLine(to: points[6])
        
        return path
    }
}

struct SPathAnimationView: View {
    let startX = 20.0
    let startY = 200.0
    let screenWidth = UIScreen.main.bounds.width - 40
    let screenHeight = UIScreen.main.bounds.height - 200
    
    var points: [CGPoint] {
        [
            CGPoint(x: startX, y: startY),
            CGPoint(x: screenWidth / 2, y: startY),
            CGPoint(x: screenWidth, y: startY),
            CGPoint(x: screenWidth / 2, y: screenHeight / 1.5),
            CGPoint(x: startX, y: screenHeight),
            CGPoint(x: screenWidth / 2, y: screenHeight),
            CGPoint(x: screenWidth, y: screenHeight)
        ]
    }

    var body: some View {
        ZStack {
            MirroredSShape(points: points)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 5, dash: [9, 5]))
            
            ForEach(points.indices, id: \.self) { index in
                Circle()
                    .fill(index % 2 == 0 ? Color.red : Color.blue)
                    .frame(width: 10, height: 10)
                    .position(points[index])
                
                Text("\(index)")
                    .foregroundColor(.black)
                    .font(.caption)
                    .bold()
                    .position(CGPoint(x: points[index].x, y: points[index].y - 15))
            }
        }
    }
}

#Preview {
    SPathAnimationView()
}
