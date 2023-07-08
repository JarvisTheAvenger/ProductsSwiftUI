//
//  FavoritesView.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: ProductListViewModel

    var body: some View {
        VStack {
            if viewModel.favorites.isEmpty {
                Text("No Favorites added")
            } else {
                List {
                    ForEach(viewModel.favorites.sorted(), id: \.self) { favoriteID in
                        if let productViewModel = viewModel.products.first(where: { $0.id == favoriteID }) {
                            NavigationLink(destination: ProductDetailsView(viewModel: productViewModel)) {
                                ProductListItemView(viewModel: productViewModel, showCart: false)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Favorites")
    }
}
