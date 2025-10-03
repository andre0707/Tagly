//
//  MainView.swift
//  Name badge Watch App
//
//  Created by Andre Albach on 27.09.25.
//

import SwiftUI

/// The main view with all the settings to configure the name badge
struct MainView: View {
    /// The environment variable
    @Environment(\.self) private var environment
    
    /// The variable which is connected to the user name edit fields
    @AppStorage("userName") private var userName: String = ""
    /// The date which is shown on the badge
    @State private var selectedDate: Date = .now
    /// The color the user selected for the background
    @State private var selectedBackground: Color = .black
    /// The color the user selected for the background
    @State private var selectedForeground: Color = .white
    
    /// Initialisation
    init() {
        selectedBackground = Color(Color.Resolved(from: UserDefaults.standard.selectedBackgroundColor))
        
        selectedForeground = Color(Color.Resolved(from: UserDefaults.standard.selectedForegroundColor))
    }
    
    /// The body of the view
    var body: some View {
        NavigationStack {
            Form {
                
//                DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                
                NavigationLink(destination: {
                    NameBadgeView(userName: userName, date: selectedDate)
                        .background(selectedBackground)
                        .foregroundStyle(selectedForeground)
                        
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
                    
                    Picker("Background", selection: $selectedBackground, content: {
                        ForEach (Color.colorPickerColors, id: \.self) { color in
                            Text(color.description)
                                .tag(color)
                                .foregroundStyle(color)
                        }
                    }, currentValueLabel: {
                        Text(verbatim: selectedBackground.description)
                    })
                    
                    Picker("Foreground", selection: $selectedForeground, content: {
                        ForEach (Color.colorPickerColors, id: \.self) { color in
                            Text(color.description)
                                .tag(color)
                                .foregroundStyle(color)
                        }
                    }, currentValueLabel: {
                        Text(verbatim: selectedForeground.description)
                    })
                    
                }, header: {
                    Text("configure your name badge")
                        .font(.headline)
                        .bold()
                })
            }
        }
        .onChange(of: selectedBackground) {
            let resolvedColor = selectedBackground.resolve(in: environment)
            UserDefaults.standard.selectedBackgroundColor = resolvedColor.rgbValue
        }
        .onChange(of: selectedForeground) {
            let resolvedColor = selectedForeground.resolve(in: environment)
            UserDefaults.standard.selectedForegroundColor = resolvedColor.rgbValue
        }
    }
}


// MARK: - Preview

#Preview {
    MainView()
}
