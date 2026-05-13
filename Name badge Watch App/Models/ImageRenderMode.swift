//
//  ImageRenderMode.swift
//  Name badge
//
//  Created by Andre Albach on 13.05.26.
//

import Foundation

/// Lists all the different rendering modes for the background image which are available
enum ImageRenderMode: Int, CaseIterable, CustomStringConvertible, Identifiable {
    case scaleToFill = 0
    case scaleToFit = 1
    
    var description: String {
        switch self {
        case .scaleToFill:
            return "scale to fill"
        case .scaleToFit:
            return "scale to fit"
        }
    }
    
    var id: Int { rawValue }
}
