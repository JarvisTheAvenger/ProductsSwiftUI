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
                                FavoriteListItemView(viewModel: productViewModel)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Favorites")
    }
}

struct FavoriteListItemView: View {
    @ObservedObject var viewModel: ProductViewModel

    var body: some View {
        HStack {
            // Display product image, name, price, and additional details
            VStack(alignment: .leading) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                }

                Text(viewModel.title)
                    .font(.headline)

                Text(viewModel.formattedPrice)
                    .font(.subheadline)
            }

            Spacer()

            // Add favorite icon button with an action to toggle the favorite state
            Button(action: {
                viewModel.toggleFavorite()
            }) {
                Image(systemName: viewModel.isInWishlist ? "heart.fill" : "heart")
                    .foregroundColor(viewModel.isInWishlist ? .red : .gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onAppear {
            viewModel.loadImage()
        }
    }
}
