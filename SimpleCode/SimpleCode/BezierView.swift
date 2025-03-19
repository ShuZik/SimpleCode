//
//  LoadingView.swift
//  SimpleCode
//
//  Created by ShuZik on 11.03.2025.
//

import SwiftUI

enum PathElementType: String, CaseIterable, Identifiable {
    case line = "Line"
    case quadCurve = "Quad Curve"
    case curve = "Curve"
    
    var id: String { self.rawValue }
}

struct PathElement: Identifiable {
    let id = UUID()
    var type: PathElementType
    var name: String
    var points: [CGPoint]
}

struct BezierView: View {
    @State private var isDebugMode: Bool = true
    @State private var pathElements: [PathElement] = []
    @State private var selectedElementType: PathElementType = .line
    @State private var selectedElement: PathElement?
    @State private var isShowingPopover = false
    
    let screenWidth = UIScreen.main.bounds.width - 40
    let screenHeight = UIScreen.main.bounds.height - 200
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(pathElements) { element in
                        SomeShape(pathElement: element)
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 5, dash: [1, 3]))
                            .onTapGesture {
                                selectedElement = element
                            }
                    }
                    
                    if isDebugMode {
                        ForEach(pathElements.indices, id: \ .self) { index in
                            ForEach(pathElements[index].points.indices, id: \ .self) { pointIndex in
                                DraggablePoint(position: $pathElements[index].points[pointIndex])
                            }
                        }
                    }
                }
                .padding()
                
                if let selectedElement = selectedElement {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .onTapGesture {
                                removeElement(selectedElement)
                            }
                        
                        Text(selectedElement.name)
                            .font(.subheadline)
                            .padding(5)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 3)
                    .padding(5)
                }
            }
            .navigationBarTitle(Text("Patch"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Toggle("DM", isOn: $isDebugMode)
                        .toggleStyle(SwitchToggleStyle(tint: .pink))
                        .font(.subheadline)
                        .padding(5)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingPopover = true
                    }) {
                        Image(systemName: "plus")
                            .font(.subheadline)
                    }
                    .popover(isPresented: $isShowingPopover) {
                        VStack(spacing: 5) {
                            ForEach(PathElementType.allCases) { type in
                                Button(type.rawValue) {
                                    selectedElementType = type
                                    addPathElement()
                                    isShowingPopover = false
                                }
                                .font(.subheadline)
                                .padding(5)
                            }
                        }
                        .frame(width: 130, height: CGFloat(PathElementType.allCases.count * 30))
                        .padding(5)
                    }
                }
            }
        }
    }
    
    private func addPathElement() {
        let count = pathElements.filter { $0.type == selectedElementType }.count + 1
        let name = "\(selectedElementType.rawValue) \(count)"
        let lastPoint = pathElements.isEmpty ? CGPoint(x: 20, y: 20) : pathElements.last!.points.last!
        let newElement: PathElement
        
        switch selectedElementType {
        case .line:
            newElement = PathElement(type: .line, name: name, points: [
                lastPoint,
                CGPoint(x: min(lastPoint.x + 150, screenWidth), y: min(lastPoint.y + 50, screenHeight))
            ])
        case .quadCurve:
            newElement = PathElement(type: .quadCurve, name: name, points: [
                lastPoint,
                CGPoint(x: min(lastPoint.x + 75, screenWidth), y: max(lastPoint.y - 50, 20)),
                CGPoint(x: min(lastPoint.x + 150, screenWidth), y: min(lastPoint.y + 50, screenHeight))
            ])
        case .curve:
            newElement = PathElement(type: .curve, name: name, points: [
                lastPoint,
                CGPoint(x: min(lastPoint.x + 50, screenWidth), y: max(lastPoint.y - 100, 20)),
                CGPoint(x: min(lastPoint.x + 100, screenWidth), y: min(lastPoint.y + 150, screenHeight)),
                CGPoint(x: min(lastPoint.x + 150, screenWidth), y: min(lastPoint.y + 50, screenHeight))
            ])
        }
        
        pathElements.append(newElement)
    }
    
    private func removeElement(_ element: PathElement) {
        pathElements.removeAll { $0.id == element.id }
        selectedElement = nil
    }
}

struct DraggablePoint: View {
    @Binding var position: CGPoint
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 12, height: 12)
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        DispatchQueue.main.async {
                            position.x = max(20, min(value.location.x, UIScreen.main.bounds.width - 20))
                            position.y = max(20, min(value.location.y, UIScreen.main.bounds.height - 200))
                        }
                    }
            )
    }
}

// MARK: - Shape
struct SomeShape: Shape {
    let pathElement: PathElement
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        switch pathElement.type {
        case .line:
            guard pathElement.points.count >= 2 else { return path }
            path.move(to: pathElement.points[0])
            path.addLine(to: pathElement.points[1])
        case .quadCurve:
            guard pathElement.points.count >= 3 else { return path }
            path.move(to: pathElement.points[0])
            path.addQuadCurve(to: pathElement.points[2], control: pathElement.points[1])
        case .curve:
            guard pathElement.points.count >= 4 else { return path }
            path.move(to: pathElement.points[0])
            path.addCurve(to: pathElement.points[3], control1: pathElement.points[1], control2: pathElement.points[2])
        }
        
        return path
    }
}

#Preview {
    BezierView()
}
