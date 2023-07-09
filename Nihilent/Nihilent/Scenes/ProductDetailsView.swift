//
//  ProductDetailsView.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import SwiftUI

struct ProductDetailsView<ViewModel>: View where ViewModel: ProductViewModelProtocol {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {

            HStack {
                Spacer()

                Image(systemName: viewModel.isInWishlist ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(viewModel.isInWishlist ? .red : .gray)
                    .onTapGesture {
                        viewModel.toggleFavorite()
                    }
                    .padding()

            }
            .padding(.horizontal)

            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }

            VStack(alignment: .center, spacing: 8) {
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(viewModel.formattedPrice)
                    .font(.headline)

                RatingView(ratingCount: viewModel.rating)
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Product Details")
        .onAppear {
            Task {
                await viewModel.loadImage()
            }
        }
    }
}

struct RatingView: View {
    let ratingCount: Double

    var body: some View {
        HStack {
            Text("Rating:")
                .font(.headline)

            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= Int(ratingCount) ? "star.fill" : "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}
