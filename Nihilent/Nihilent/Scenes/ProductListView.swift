//
//  ProductListView.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if viewModel.products.isEmpty {
                    Text("No products available")
                } else {
                    List(viewModel.products, id: \.id) { productVM in
                        NavigationLink(destination: ProductDetailsView(viewModel: productVM)) {
                            ProductListItemView(viewModel: productVM)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Product List")
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

struct ProductListItemView: View {
    @StateObject var viewModel: ProductViewModel

    var body: some View {
        HStack {
            // Display product image, name, price, and add to cart button
            VStack(alignment: .leading) {
                // Product image
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

                // Product name
                Text(viewModel.title)
                    .font(.headline)

                // Product price
                Text(viewModel.formattedPrice)
                    .font(.subheadline)
            }

            Spacer()

            // Add to cart button
            if viewModel.isAddToCartEnabled {
                Button(action: {
                    // Handle add to cart action
                }) {
                    Image(systemName: "cart")
                        .foregroundColor(.blue)
                }
            }

            // Favorite icon button
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
