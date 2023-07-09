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
                            ProductListItemView(viewModel: productVM, showCart: true)
                        }
                    }
                    .listStyle(DefaultListStyle())
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
    let showCart: Bool

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
            }

            VStack(alignment: .leading) {
                // Product name
                Text(viewModel.title)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Product price
                Text(viewModel.formattedPrice)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 8)

            Spacer()

            HStack(spacing: 16) {
                // Add to cart button
                if viewModel.isAddToCartEnabled && showCart {
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
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.loadImage()
        }
    }
}

