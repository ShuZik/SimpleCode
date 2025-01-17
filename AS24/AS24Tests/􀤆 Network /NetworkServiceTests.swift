//
//  NetworkServiceTests.swift
//  AS24Tests
//
//  Created by ShuZik on 17.01.2025.
//

import XCTest
import Combine
@testable import AS24

final class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var cancellables = Set<AnyCancellable>()

    static let mockCars: [CarModel] = CarModel.mockCars

    func fetchCars() async throws -> [CarModel] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock fetch failed"])
        } else {
            return MockNetworkService.mockCars
        }
    }
}
