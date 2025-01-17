//
//  CarDetailView.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import SwiftUI

struct CarDetailView: View {
    
    @ObservedObject private var dispatcher: CarDetailDispatcher
        
    init(dispatcher: CarDetailDispatcher = CarDetailDispatcher(), car: CarModel) {
        self.dispatcher = dispatcher
        self.dispatcher.dispatch(.setCar(car))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    if let imageUrl = dispatcher.store.car.images {
                        FullImageView(imageUrl, 300)
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            PrimaryText("\(dispatcher.store.car.make) \(dispatcher.store.car.model) \(dispatcher.store.car.firstRegistration ?? "")")
                            
                            HStack(spacing: 8) {
                                AccsentText("$\(dispatcher.store.car.price)")
                                SecondaryText("• \(dispatcher.store.car.price * 42) грн")
                            }
                            
                            LazyVGrid(columns: [GridItem(.flexible(), alignment: .leading)], spacing: 8) {
                                SystemIconText("speedometer", "\(dispatcher.store.car.mileage ?? 0) miles")
                                SystemIconText("gearshape", "Automatic")
                                SystemIconText("fuelpump", "\(dispatcher.store.car.fuel)")
                                SystemIconText("location", dispatcher.store.car.seller?.city ?? "")
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                if let phone = dispatcher.store.car.seller?.phone {
                    Button(action: {
                        dispatcher.dispatch(.callToSeller(phone))
                    }) {
                        PrimaryText(phone)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                } else {
                    PrimaryText("No Phone 🥺")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let dispatcher = CarDetailDispatcher() // We could use Dependency Inversion if needed.
    return CarDetailView(dispatcher: dispatcher, car: CarModel.mockCar)
}
