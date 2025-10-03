//
//  NameBadgeView.swift
//  Name badge
//
//  Created by Andre Albach on 30.09.25.
//

import SwiftUI


/// The view which shows the configured name badge
struct NameBadgeView: View {
    
    /// The user name to display
    let userName: String
    /// The date to show below the
    let date: Date
    
    /// The dismiss view action
    @Environment(\.dismiss) private var dismiss
    
    /// The body of the view
    var body: some View {
        VStack {
            Text(verbatim: userName)
                .font(.largeTitle)
                .padding(.vertical)
            
            
            Text(date.formatted(date: .numeric, time: .omitted))
                .font(.title3)
        }
        .contentShape(Rectangle())
        
        .containerRelativeFrame([.horizontal, .vertical])
//        .foregroundStyle(Color.black)
//        .background(Color.blue)
        
        .onTapGesture {
            dismiss()
        }
        
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

#Preview {
    NameBadgeView(userName: "John Doe", date: .now)
}
