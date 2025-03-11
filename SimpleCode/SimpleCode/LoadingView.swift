//
//  LoadingView.swift
//  SimpleCode
//
//  Created by ShuZik on 11.03.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var isDebugMode: Bool = true
    
    let startX = 20.0
    let startY = 100.0
    let screenWidth = UIScreen.main.bounds.width - 20
    let screenHeight = UIScreen.main.bounds.height - 300
    
    var points: [CGPoint] {
        [
            // 0
            CGPoint(x: startX, y: startY),
            // 1
            CGPoint(x: screenWidth / 2, y: startY),
            // 2
            CGPoint(x: screenWidth, y: startY),
            // 3
            CGPoint(x: screenWidth / 2, y: screenHeight / 1.7),
            // 4
            CGPoint(x: startX, y: screenHeight),
            // 5
            CGPoint(x: screenWidth / 2, y: screenHeight),
            // 7
            CGPoint(x: screenWidth, y: screenHeight)
        ]
    }

    var body: some View {
        VStack {
            Toggle("Debug Mode", isOn: $isDebugMode)
                .toggleStyle(SwitchToggleStyle(tint: Color.Base.Pink))
                .font(.headline)
                .padding()
            
            ZStack {
                SomeShape(points: points)
                    .stroke(Color.Base.Primary, style: StrokeStyle(lineWidth: 5, dash: [1, 3]))
                
                if isDebugMode {
                    ForEach(points.indices, id: \.self) { index in
                        Circle()
                            .fill(index % 2 == 0 ? Color.Base.Primary : Color.Base.Pink)
                            .frame(width: 10, height: 10)
                            .position(points[index])
                        
                        Text("\(index)")
                            .foregroundColor(Color.Label.Primary)
                            .font(.caption)
                            .bold()
                            .position(CGPoint(x: points[index].x, y: points[index].y - 15))
                    }
                }
                
                PathAnimationView(bezierPath: makeBezierPath())
            }
        }
        .background(Color.Base.Background)
    }

    func makeBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: points[0])
        path.addLine(to: points[1])
        path.addQuadCurve(to: points[3], controlPoint: points[2])
        path.addQuadCurve(to: points[5], controlPoint: points[4])
        path.addLine(to: points[6])
        return path
    }
}

// MARK: - Shape
struct SomeShape: Shape {
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

// MARK: - UIViewRepresentable
struct PathAnimationView: UIViewRepresentable {
    let bezierPath: UIBezierPath

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let animatedImageView = UIImageView(image: UIImage(named: "ShuZik"))
        animatedImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 22)
        containerView.addSubview(animatedImageView)
        
        startAnimation(for: animatedImageView)

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    private func startAnimation(for view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = bezierPath.cgPath
        animation.duration = 8.0
        animation.repeatCount = .infinity
        animation.calculationMode = .paced
        
        view.layer.add(animation, forKey: "move")
    }
}

#Preview {
    LoadingView()
}
