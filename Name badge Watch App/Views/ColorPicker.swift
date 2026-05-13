//
//  ColorPicker.swift
//  Name badge
//
//  Created by Andre Albach on 13.05.26.
//

import SwiftUI


/// This view lets the user pick a color
/// It has a fix defined list of colors `Color.colorPickerColors` from which the user can pick one.
struct ColorPicker: View {
    
    /// The title which should be used for the picker
    let pickerTitle: LocalizedStringKey
    
    /// Binding to the selected color
    @Binding var selectedColor: String
    
    /// The body of the view
    var body: some View {
        if #available(watchOS 11.0, *) {
            Picker(pickerTitle, selection: $selectedColor, content: {
                ForEach (Color.colorPickerColors, id: \.self) { color in
                    Text(verbatim: color.colorName)
                        .tag(color.description)
                        .foregroundStyle(color)
                }
            }, currentValueLabel: {
                Text(verbatim: Color(from: selectedColor).colorName)
            })
            
        } else {
            Picker(pickerTitle, selection: $selectedColor, content: {
                ForEach (Color.colorPickerColors, id: \.self) { color in
                    Text(verbatim: color.colorName)
                        .tag(color.description)
                        .foregroundStyle(color)
                }
            })
        }
    }
}
