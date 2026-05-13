//
//  ImageScaleModifier.swift
//  Name badge
//
//  Created by Andre Albach on 13.05.26.
//

import SwiftUI

extension View {
    /// This modifiers applies the correct image scaling based on the current user settings.
    func scaleImageByUserSettings() -> some View {
        self.modifier(ImageScaleModifier())
    }
}

/// This modifier applies the correct scale to modification based on the current user settings.
struct ImageScaleModifier: ViewModifier {
    func body(content: Content) -> some View {
        switch UserDefaults.standard.backgroundImageRenderingMode {
        case .scaleToFill:
            content
                .scaledToFill()
        case .scaleToFit:
            content
                .scaledToFit()
        }
    }
}
