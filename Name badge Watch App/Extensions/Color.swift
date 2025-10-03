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
