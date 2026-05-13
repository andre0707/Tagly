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
    /// The location to display
    let location: String?
    /// The date to show below the
    let date: Date
    /// The data of the background image
    let imageData: Data?
    /// The opacity of the background image
    let imageOpacity: Double
    
    /// The dismiss view action
    @Environment(\.dismiss) private var dismiss
    
    /// The body of the view
    var body: some View {
        
        ZStack {
            if let imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaleImageByUserSettings()
                    .ignoresSafeArea()
                    .overlay(
                        Color.black.opacity(1 - imageOpacity/100)
                    )
            }
            
            VStack {
                Text(verbatim: userName)
                    .font(.largeTitle)
//                    .padding(.vertical)
                
                if let location {
//                    Text(verbatim: "@ ")
//                        .font(.largeTitle)
                    
                    Text(verbatim: "@ \(location)")
                        .font(.title3)
//                        .padding(.vertical)
                }
                
                Text(date.formatted(date: .numeric, time: .omitted))
                    .font(.title3)
                    .padding(.top)
            }
            .contentShape(Rectangle())
        }
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
    NameBadgeView(userName: "John Doe", location: nil, date: .now, imageData: nil, imageOpacity: 0)
}

#Preview("with location") {
    NameBadgeView(userName: "John Doe", location: "GC12CRJ", date: .now, imageData: nil, imageOpacity: 0)
}
