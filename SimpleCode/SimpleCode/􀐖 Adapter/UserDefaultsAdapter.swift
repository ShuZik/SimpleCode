//
//  UserDefaultsAdapter.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import Foundation

// MARK: Defaults Protocol

/// Do not User this protocol directly !!!
protocol UserDefaultsProtocol {
    static func get<T: Any>(_ objectType: T.Type, key: Keys.UserDefaults) -> T?
    static func set<T: Any>(_ object: T, key: Keys.UserDefaults)
}

extension UserDefaultsProtocol {
    static func get<T: Any>(_: T.Type, key: Keys.UserDefaults) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }

    static func set<T: Any>(_ object: T, key: Keys.UserDefaults) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
    }
}

// MARK: - Theme Protocol
protocol UserDefaultsThemeProtocol: UserDefaultsProtocol {
    static func getTheme() -> ThemeType
    static func setTheme(_ newValue: ThemeType)
}

extension UserDefaultsThemeProtocol {
    static func getTheme() -> ThemeType {
        #if DEBUG
//            return Theme.Main
            return Theme.Mono
        #else
            guard let themeValue = get(String.self, key: Keys.UserDefaults.Theme) else {
                return Theme.Main
            }

            return ThemeMock(rawValue: themeValue) ?? Theme(rawValue: themeValue) ?? .Main
        #endif
    }

    static func setTheme(_ newValue: ThemeType) {
        set(newValue.rawValue, key: Keys.UserDefaults.Theme)
    }
}
