//
//  Keys.swift
//  iOS
//
//  Created by ShuZik on 13.02.2024.
//  Copyright © 2024 Applica. All rights reserved.
//

import Foundation

enum Keys {
    // Some defaults keys...
}

// MARK: - Performance
extension Keys {
    enum Performance: String {
        case records = "RECORDS_SYNC"
    }
}

// MARK: - UserDefaults
extension Keys {
    enum UserDefaults: String, CaseIterable {
        case Theme
    }
}
