//
//  DishInfoView.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI

public struct DishInfoView: View {
    
    let dishId: String
    @StateObject private var viewModel: DishInfoViewModel = DishInfoViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    
    public var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.state {
                case .loading:
                    ProgressView("Loading dish details...")
                case .loaded(let dish):
                    ScrollView {
                        asyncImageView(url: dish.thumbnailURL?.absoluteString ?? "",
                                       width: UIScreen.main.bounds.width, height: 300,
                                       placeholderShape: Rectangle())
                        makeSection(header: "Dish name", body: dish.name)
                        makeSection(header: "Instructions", body: dish.instructions.joined(separator: "\n"))
                        if let sourceURL = dish.sourceURL {
                            makeSection(header: "Source", body: sourceURL.absoluteString)
                        }
                        if let youtubeURL = dish.youtubeURL {
                            makeSection(header: "YouTube", body: youtubeURL.absoluteString)
                        }
                    }
                    .ignoresSafeArea(edges: .top)
                    .scrollIndicators(.hidden)
                case .error(let errorMessage):
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchDishInfo(dishId: dishId)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    coordinator.goBack()
                }, label: {})
            }
        }
    }
}

#Preview {
    DishInfoView(dishId: "53049")
}
