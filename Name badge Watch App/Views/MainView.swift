//
//  MainView.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 27.09.25.
//

import PhotosUI
import SwiftUI


/// The main view with all the settings to configure the name badge
struct MainView: View {
    /// The environment variable
    @Environment(\.self) private var environment
    
    /// The variable which is connected to the user name edit fields
    @AppStorage(UserDefaults.Keys.userName) private var userName: String = ""
    /// The variable which is connected to the location edit fields
    @AppStorage(UserDefaults.Keys.location) private var location: String = ""
    /// Indicator, if the badge view is shown or not
    @AppStorage(UserDefaults.Keys.isBadgeViewDisplayed) private var isBadgeViewDisplayed: Bool = false
    
    /// The main view model
    @StateObject private var viewModel = MainViewModel()
    
    /// The body of the view
    var body: some View {
        NavigationStack {
            Form {
                
//                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                
                Button {
                    isBadgeViewDisplayed = true
                } label: {
                    Text("Show badge")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
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
            
            // MARK: - Navigation destination
            .navigationDestination(isPresented: $isBadgeViewDisplayed) {
                NameBadgeView(userName: userName,
                              location: location.isEmpty ? nil : location,
                              date: viewModel.selectedDate,
                              imageData: viewModel.useBackgroundImage ? viewModel.imageData : nil,
                              imageOpacity: viewModel.backgroundImageOpacity)
                .background(Color(from: viewModel.selectedBackground))
                .foregroundStyle(Color(from: viewModel.selectedForeground))
            }
        }
    }
}


// MARK: - Preview

#Preview {
    MainView()
}
