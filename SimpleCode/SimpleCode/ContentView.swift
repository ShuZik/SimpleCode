//
//  ContentView.swift
//  SimpleCode
//
//  Created by ShuZik on 01.11.2024.
//

import SwiftUI

struct ContentView: View {
    // Модель для представления экрана в списке
    struct ScreenItem: Identifiable {
        let id = UUID()
        let title: String
        let destination: AnyView
        
        init<V: View>(title: String, destination: V) {
            self.title = title
            self.destination = AnyView(destination)
        }
    }
    
    // Массив доступных экранов
    private let screens: [ScreenItem] = [
        ScreenItem(title: "Hello View", destination: HelloView()),
        ScreenItem(title: "Image Text View", destination: ImgeTextView(text: "Hello")),
        ScreenItem(title: "Progress Chart", destination: ProgressChartView(portions: ProgressChartModel.mock ,day: 5)),
        ScreenItem(title: "Gradient View", destination: GradientView()),
        ScreenItem(title: "Matrix Rain", destination: MatrixRainView())
    ]
    
    var body: some View {
        NavigationView {
            List(screens) { screen in
                NavigationLink(destination: screen.destination) {
                    Text(screen.title)
                        .font(.system(size: 16, weight: .medium))
                }
            }
            .navigationTitle("SimpleCode")
        }
    }
}

// Предварительный просмотр
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
