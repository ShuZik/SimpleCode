//
//  CarRowView.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import Combine
import SwiftUI

struct CarsListRow: View {
    let car: CarModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            FullImageView(car.images, 200)
            
            VStack(alignment: .leading, spacing: 12) {
                PrimaryText("\(car.make) \(car.model) \(car.firstRegistration ?? "")")
                
                HStack {
                    AccsentText("$\(car.price)")
                    SecondaryText("•  \(car.price * 42) грн") // Local currency
                }
                
                LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading), GridItem(.flexible(), alignment: .leading)], spacing: 8) {
                    SystemIconText("speedometer", "\(car.mileage ?? 0) miles")
                    SystemIconText("gearshape", "Automatic")
                    SystemIconText("fuelpump", "\(car.fuel)")
                    SystemIconText("location", car.seller?.city ?? "")
                }
                
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
        .contentShape(Rectangle())
//        .onTapGesture {
//            onRowTap()
//        }
    }
    
    private func onRowTap() {
//        print("Row tapped for car: \(car.make) \(car.model)")
    }
}

#Preview {
    VStack {
        CarsListRow(car: CarModel.mockCar)
        CarsListRow(car: CarModel.mockCarNoImage)
    }
}
