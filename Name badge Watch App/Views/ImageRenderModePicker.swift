//
//  ImageRenderModePicker.swift
//  Name badge
//
//  Created by Andre Albach on 13.05.26.
//


import SwiftUI


/// A simple render mode picker UI element.
/// It provides all the options from `ImageRenderMode` and presents them in a picker.
struct ImageRenderModePicker: View {
    
    /// Binding to the selected render mode
    @Binding var selection: ImageRenderMode
    
    /// The body of the view
    var body: some View {
        Picker("Render mode", selection: $selection, content: {
            ForEach (ImageRenderMode.allCases) { renderMode in
                Text(verbatim: renderMode.description)
                    .tag(renderMode)
            }
        })
        
    }
}

