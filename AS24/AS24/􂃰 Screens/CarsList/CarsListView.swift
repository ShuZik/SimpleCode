//
//  CarsListView.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct CarsListView: View {
    
    @ObservedObject private var dispatcher: CarsListDispatcher
    
    init(dispatcher: CarsListDispatcher = CarsListDispatcher()) {
        self.dispatcher = dispatcher
    }
    
    var body: some View {
        NavigationStack {
            List(dispatcher.store.cars) { car in
                CarsListRow(car: car)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    .onTapGesture {
                        dispatcher.dispatch(.selectCar(car))
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Cars")
            .navigationDestination(isPresented: Binding(
                get: { dispatcher.store.selectedCar != nil },
                set: { if !$0 { dispatcher.dispatch(.selectCar(nil)) } }
            ), destination: {
                if let car = dispatcher.store.selectedCar {
                    CarDetailView(car: car)
                }
            })
        }
        .task {
            dispatcher.dispatch(.loadCars)
        }
    }
}
 
#Preview {
    let dispatcher = CarsListDispatcher() // We could use Dependency Inversion if needed.
    return CarsListView(dispatcher: dispatcher)
}
