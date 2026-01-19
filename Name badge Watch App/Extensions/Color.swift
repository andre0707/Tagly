//
//  Color.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 28.09.25.
//

import SwiftUI

extension Color.Resolved {
    var rgbValue: UInt32 {
        let r = UInt32(max(red, 0) * 255) << 16
        let g = UInt32(max(green, 0) * 255) << 8
        let b = UInt32(max(blue, 0) * 255)
        
        return r + g + b
    }
    
    init(from rgbValue: UInt32) {
        self.init(red: Float((rgbValue >> 16) & 0xFF) / 255.0,
                  green: Float((rgbValue >> 8) & 0xFF) / 255.0,
                  blue: Float(rgbValue & 0xFF) / 255.0)
    }
}

extension Color {
    init(from descriptionName: String) {
        self = Color.colorPickerColors.first(where: { $0.description == descriptionName }) ?? .black
    }
}

extension Color {
    /// A list of all the supported colors from which the user can pick
    static let colorPickerColors: [Color] = [
        .black,
        .white,
        .blue,
        .gray,
        .red,
        .green,
        .yellow,
        .orange,
        .indigo,
        .mint,
        .pink,
        .purple,
        .cyan,
        .brown
    ]
}

extension Color {
    /// The naming of the color as a localized string
    var colorName: String {
        switch self {
        case .black: String(localized: "black")
        case .white: String(localized: "white")
        case .blue: String(localized: "blue")
        case .gray: String(localized: "gray")
        case .red: String(localized: "red")
        case .green: String(localized: "green")
        case .yellow: String(localized: "yellow")
        case .orange: String(localized: "orange")
        case .indigo: String(localized: "indigo")
        case .mint: String(localized: "mint")
        case .pink: String(localized: "pink")
        case .purple: String(localized: "purple")
        case .cyan: String(localized: "cyan")
        case .brown: String(localized: "brown")
        
        default: String(localized: "other")
        }
    }
}
