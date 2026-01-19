//
//  MainView.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 27.09.25.
//

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
                                  date: selectedDate)
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
                    
                    Picker("Background color", selection: $viewModel.selectedBackground, content: {
                        ForEach (Color.colorPickerColors, id: \.self) { color in
                            Text(verbatim: color.colorName)
                                .tag(color.description)
                                .foregroundStyle(color)
                        }
                    }, currentValueLabel: {
                        Text(verbatim: Color(from: viewModel.selectedBackground).colorName)
                    })
                    
                    Picker("Font color", selection: $viewModel.selectedForeground, content: {
                        ForEach (Color.colorPickerColors, id: \.self) { color in
                            Text(verbatim: color.colorName)
                                .tag(color.description)
                                .foregroundStyle(color)
                        }
                    }, currentValueLabel: {
                        Text(verbatim: Color(from: viewModel.selectedForeground).colorName)
                    })
                    
                }, header: {
                    Text("configure your name badge")
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
