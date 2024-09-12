//
//  DishInfoView+Extension.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI

extension View {
    
    //DishInfoView
    func asyncImageView<PlaceholderShape: Shape>(
        url: String,
        width: CGFloat,
        height: CGFloat? = nil,
        placeholderShape: PlaceholderShape
    ) -> some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                // Placeholder view when image is being loaded
                placeholderShape
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: width, height: height)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    )
            case .success(let image):
                // Successfully loaded image with a smooth transition
                image
                    .resizable()
                    .scaledToFill()  // Maintain aspect ratio without stretching
                    .frame(width: width, height: height)
                    .cornerRadius(8) // Optional corner radius for better UI
                    .transition(.opacity) // Smooth fade-in transition
            case .failure:
                // Display a placeholder if loading fails
                placeholderShape
                    .fill(Color.red.opacity(0.3)) // Indicate failure with a different color
                    .frame(width: width, height: height)
                    .overlay(
                        Text("Image failed to load")
                            .font(.caption)
                            .foregroundColor(.red)
                    )
            @unknown default:
                // Fallback for any unknown state
                placeholderShape
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: width, height: height)
            }
        }
    }
    
    //DishInfoView
    func makeSection(header: String, body: String) -> some View {
        return VStack(alignment: .leading) {
            Section {
                if let url = URL(string: body), UIApplication.shared.canOpenURL(url) {
                    // If the body is a valid URL, render it as a clickable Link
                    Link(body, destination: url)
                        .font(.body)
                        .foregroundStyle(.link)
                } else {
                    // Otherwise, render it as a regular Text
                    Text(body)
                        .font(.body)
                }
            } header: {
                Text(header)
                    .font(.title2)
                    .fontWeight(.semibold)
            }.padding(.leading)
            Divider()
        }
    }
}
