//
//  Colors.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import SwiftUI

// MARK: Views
extension Color {
    enum Base {
        static var Primary = colorForTheme("Primary")
        static var Secondary = colorForTheme("Secondary")
        static var Background = colorForTheme("Background")
    }
}

// MARK: Buttons
extension Color {
    enum Button {
        static var Primary = colorForTheme("Primary_Text")
        static var Secondary = colorForTheme("Secondary_Text")
    }
}

// MARK: Labels
extension Color {
    enum Label {
        static var Primary = colorForTheme("Primary_Label")
        static var Secondary = colorForTheme("Secondary_Label")
    }
}

// MARK: Images
extension Color {
    enum Image {
        static var Primary = colorForTheme("Primary_Label")
        static var Secondary = colorForTheme("Secondary_Label")
    }
}

// MARK: Private theme
extension Color: UserDefaultsThemeProtocol {
    static func colorForTheme(_ suffix: String) -> Self {
        let theme = getTheme().rawValue

        return Color(theme + "_" + suffix)
    }
}
