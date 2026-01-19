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
        
        static let userName = "userName"
        static let location = "location"
    }
    
    /// The raw numeric value of the last selected background color
    var selectedBackgroundColor: String? {
        get {
            string(forKey: Keys.selectedBackgroundColor)
        }
        set {
            set(newValue, forKey: Keys.selectedBackgroundColor)
        }
    }
    
    /// The raw numeric value of the last selected foreground color
    var selectedForegroundColor: String? {
        get {
            string(forKey: Keys.selectedForegroundColor)
        }
        set {
            set(newValue, forKey: Keys.selectedForegroundColor)
        }
    }
}


extension UserDefaults {
    
    /// This function extends the existing get object function to pass in a default value and also the option to use the `AppSetting` enum instead of strings as the key
    /// - Parameters:
    ///   - key: The key under which the setting will be stored
    ///   - defaultValue: This value will be used if there is nothing saved for `key` yet
    /// - Returns: The stored value for `key` if there is one. `defaultValue` otherwise
    func object<T>(forKey key: String, withDefault defaultValue: T) -> T {
        return (self.object(forKey: key) as? T) ?? defaultValue
    }
}
