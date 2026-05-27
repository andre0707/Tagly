//
//  MainViewModel.swift
//  Name badge
//
//  Created by Andre Albach on 27.05.26.
//

import PhotosUI
import SwiftUI


/// The view model for the main view
final class MainViewModel: ObservableObject {
    /// The color the user selected for the background
    @Published var selectedBackground: String = UserDefaults.standard.selectedBackgroundColor ?? Color.black.description {
        didSet {
            UserDefaults.standard.selectedBackgroundColor = selectedBackground
        }
    }
    
    /// The color the user selected for the background
    @Published var selectedForeground: String = UserDefaults.standard.selectedForegroundColor ?? Color.white.description {
        didSet {
            UserDefaults.standard.selectedForegroundColor = selectedForeground
        }
    }
    
    /// Indicator, if the selected background image should be used or a plain background color
    @Published var useBackgroundImage: Bool = UserDefaults.standard.useBackgroundImage {
        didSet {
            UserDefaults.standard.useBackgroundImage = useBackgroundImage
        }
    }
    
    @Published var selectedItem: PhotosPickerItem? = nil {
        didSet {
            guard let selectedItem else { return }
            Task {
                do {
                    // Prefer requesting Data for control over size/encoding
                    if let data = try await selectedItem.loadTransferable(type: Data.self) {
                        self.imageData = data
                    }
                } catch {
                    // Handle error
                    print("Error: \(error)")
                }
            }
        }
    }
    
    @Published var imageData: Data? = UserDefaults.standard.backgroundImageData {
        didSet {
            UserDefaults.standard.backgroundImageData = imageData
        }
    }
    
    @Published var backgroundImageRenderingMode: ImageRenderMode = UserDefaults.standard.backgroundImageRenderingMode {
        didSet {
            UserDefaults.standard.backgroundImageRenderingMode = backgroundImageRenderingMode
        }
    }
    
    @Published var backgroundImageOpacity: Double = UserDefaults.standard.backgroundImageOpacity {
        didSet {
            UserDefaults.standard.backgroundImageOpacity = backgroundImageOpacity
        }
    }
    
    /// The date which is shown on the badge
    @Published var selectedDate: Date = .now
    
    
    init() {
        /// For now we will always update the current date when the app opens again
        NotificationCenter.default.addObserver(forName: WKApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            
            self.selectedDate = .now
        }
    }
}
