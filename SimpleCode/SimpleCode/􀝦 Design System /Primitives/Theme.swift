//
//  Theme.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import UIKit

protocol ThemeType {
    var rawValue: String { get }
}

enum Theme: String, ThemeType {
    case Main
    case Mono
}

enum ThemeMock: String, ThemeType {
    case Orange = "Mock_Orange"
    case Green = "Mock_Green"
}
