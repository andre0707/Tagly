//
//  MainView.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 27.09.25.
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
}

/// The main view with all the settings to configure the name badge
struct MainView: View {
    /// The environment variable
    @Environment(\.self) private var environment
    
    /// The variable which is connected to the user name edit fields
    @AppStorage(UserDefaults.Keys.userName) private var userName: String = ""
    /// The variable which is connected to the location edit fields
    @AppStorage(UserDefaults.Keys.location) private var location: String = ""
    /// The date which is shown on the badge
    @State private var selectedDate: Date = .now
    
    @StateObject private var viewModel = MainViewModel()
    
    /// The body of the view
    var body: some View {
        NavigationStack {
            Form {
                
//                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                
                NavigationLink(destination: {
                    NameBadgeView(userName: userName,
                                  location: location.isEmpty ? nil : location,
                                  date: selectedDate,
                                  imageData: viewModel.useBackgroundImage ? viewModel.imageData : nil,
                                  imageOpacity: viewModel.backgroundImageOpacity)
                    .background(Color(from: viewModel.selectedBackground))
                    .foregroundStyle(Color(from: viewModel.selectedForeground))
                    
                }, label: {
                    Text("Show badge")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                
                Section(content: {
                    TextField("enter your username", text: $userName)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    TextField("enter the location", text: $location)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    ColorPicker(pickerTitle: "Background color",
                                selectedColor: $viewModel.selectedBackground)
                    
                    ColorPicker(pickerTitle: "Font color",
                                selectedColor: $viewModel.selectedForeground)
                    
                }, header: {
                    Text("Configure your name badge")
                        .font(.headline)
                        .bold()
                })
                
                Section(content: {
                    
                    Toggle("Use background image", isOn: $viewModel.useBackgroundImage)
                    
                    PhotosPicker(
                        selection: $viewModel.selectedItem,
                        matching: .images) {
                        Text("Pick background image")
                    }
                    
                    ImageRenderModePicker(selection: $viewModel.backgroundImageRenderingMode)
                    
                    OpacityPicker(opacity: $viewModel.backgroundImageOpacity)
                    
                }, header: {
                    Text("Background image")
                        .font(.headline)
                        .bold()
                })
            }
        }
    }
}


// MARK: - Preview

#Preview {
    MainView()
}
