//
//  CarModel.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import Foundation

struct CarModel: Codable, Identifiable, Hashable {
    let id: Int
    let make: String
    let model: String
    let price: Int
    let firstRegistration: String?
    let mileage: Int?
    let fuel: String
    let images: [CarImageModel]?
    let description: String
    let seller: CarSellerModel?
    
    // Для корректной работы с Hashable
    static func == (lhs: CarModel, rhs: CarModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct CarImageModel: Codable, Hashable {
    let url: String
}

struct CarSellerModel: Codable, Hashable {
    let type: String
    let phone: String
    let city: String
}

// Mocks
extension CarModel {
    static let mockCar =
        CarModel(id: 1,
                 make: "Mock Volvo",
                 model: "XC90",
                 price: 19500,
                 firstRegistration: "2018",
                 mileage: 149000,
                 fuel: "Gasoline",
                 images: [
                    CarImageModel(url: "https://loremflickr.com/320/240/volvo"),
                    CarImageModel(url: "https://loremflickr.com/320/241/BMW"),
                    CarImageModel(url: "https://loremflickr.com/320/240/cat")
                 ],
                 description: "Great condition, one owner, no accidents.",
                 seller: CarSellerModel(type: "Dealer", phone: "(073) 555 44 33", city: "Kyiv")
        )
    
    static let mockCarNoImage =
        CarModel(id: 1,
                 make: "Mock Ford",
                 model: "Mustang",
                 price: 19500,
                 firstRegistration: "2022",
                 mileage: 149000,
                 fuel: "Gasoline",
                 images: nil,
                 description: "Great condition, one owner, no accidents.",
                 seller: CarSellerModel(type: "Dealer", phone: "(073) 555 44 33", city: "Kyiv")
        )
    
    static let mockCars: [CarModel] = [
        CarModel(id: 1,
                 make: "Mock Volvo",
                 model: "XC90",
                 price: 19500,
                 firstRegistration: "2018",
                 mileage: 149000,
                 fuel: "Gasoline",
                 images: [
                    CarImageModel(url: "https://loremflickr.com/320/240/volvo"),
                    CarImageModel(url: "https://loremflickr.com/320/241/BMW"),
                    CarImageModel(url: "https://loremflickr.com/320/240/cat")
                 ],
                 description: "Great condition, one owner, no accidents.",
                 seller: CarSellerModel(type: "Dealer", phone: "(073) 555 44 33", city: "Kyiv")
                ),
        
        CarModel(id: 2,
                 make: "Mock Audi",
                 model: "A7",
                 price: 160000,
                 firstRegistration: "2015",
                 mileage: 400,
                 fuel: "Gasoline",
                 images: [CarImageModel(url: "")],
                 description: "No description available.",
                 seller: CarSellerModel(type: "Private", phone: "+123456789", city: "Krakow")
                ),
        
        CarModel(id: 3,
                 make: "Mock BMW",
                 model: "X7",
                 price: 160000,
                 firstRegistration: "2024",
                 mileage: 400,
                 fuel: "Gasoline",
                 images: nil,
                 description: "No description available.",
                 seller: CarSellerModel(type: "Private", phone: "+123456789", city: "Krakow"))
    ]
}
