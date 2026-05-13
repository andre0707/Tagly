//
//  OpacityPicker.swift
//  Name badge
//
//  Created by Andre Albach on 13.05.26.
//

import SwiftUI


/// A picker view which allows the user to pick a opacity.
/// The range goes from 0 to 100.
/// When applying this range, it must be adjusted to a value between 0.0 and 1.0
struct OpacityPicker: View {
    @Binding var opacity: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Opacity")
            
            Slider(value: $opacity,
                   in: 0...100,
                   label: {
                Text(verbatim: "\(Int(opacity))")
            }, minimumValueLabel: {
                Text(verbatim: "0")
            }, maximumValueLabel: {
                Text(verbatim: "100")
            })
        }
    }
}
