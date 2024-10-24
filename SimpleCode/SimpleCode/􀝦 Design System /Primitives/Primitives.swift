//
//  Primitives.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//

import Foundation

enum Primitive {
    enum CornerRadius {
        static let Button: CGFloat = 10
    }

    enum FontSize: CGFloat {
        case H14 = 14
        case H17 = 17
        case H22 = 22
        case H34 = 34
        case H44 = 44
    }

    // MARK: Experimental

    enum Padding {
        enum View {
            static let S40: CGFloat = 40
            static let S32: CGFloat = 32
            static let S16: CGFloat = 16
            static let S8: CGFloat = 8
        }

        enum Button {
            static let Vertical: CGFloat = 14
            static let Horizontal: CGFloat = 20
        }
    }
}
