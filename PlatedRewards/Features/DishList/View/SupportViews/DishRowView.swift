//
//  DishRowView.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/10/24.
//

import SwiftUI

public struct DishRowView: View {
    let dish: Dish

    public var body: some View {
        HStack {
            asyncImageView(url: dish.thumbnailURL?.absoluteString ?? "", width: 70, height: 70, placeholderShape: RoundedRectangle(cornerRadius: 5.0))

            Text(dish.name)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

