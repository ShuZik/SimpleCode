//
//  NetworkService.swift
//  AS24
//
//  Created by ShuZik on 16.01.2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol NetworkServiceProtocol {
    func fetchCars() async throws -> [CarModel]
}

final class NetworkService: NetworkServiceProtocol {
    static var shared: NetworkServiceProtocol = NetworkService()
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchCars() async throws -> [CarModel] {
        guard let url = URL(string: "http://private-fe87c-simpleclassifieds.apiary-mock.com/") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await session.data(from: url)
        let cars = try JSONDecoder().decode([CarModel].self, from: data)
        return cars
    }
}
