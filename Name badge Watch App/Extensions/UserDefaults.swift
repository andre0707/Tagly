//
//  Keys.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 28.09.25.
//

import Foundation

extension UserDefaults {
    /// Lists all the user defaults keys for stored settings
    enum Keys {
        static let selectedBackgroundColor = "selectedBackgroundColor"
        static let selectedForegroundColor = "selectedForegroundColor"
    }
    
    /// The raw numeric value of the last selected background color
    var selectedBackgroundColor: UInt32 {
        get {
            UInt32(integer(forKey: Keys.selectedBackgroundColor))
        } set {
            set(Int(newValue), forKey: Keys.selectedBackgroundColor)
        }
    }
    
    /// The raw numeric value of the last selected foreground color
    var selectedForegroundColor: UInt32 {
        get {
            UInt32(integer(forKey: Keys.selectedForegroundColor))
        } set {
            set(Int(newValue), forKey: Keys.selectedForegroundColor)
        }
    }
}
