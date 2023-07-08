//
//  ContentView.swift
//  Nihilent
//
//  Created by Rahul on 07/07/23.
//

import SwiftUI

struct TabbarView: View {
    @StateObject private var productListViewModel = ProductListViewModel(provider: ProductListProvider())

    var body: some View {
        TabView {
            NavigationView {
                ProductListView(viewModel: productListViewModel)
            }
            .tabItem {
                Label("Products", systemImage: "list.bullet")
            }

            NavigationView {
                FavoritesView(viewModel: productListViewModel)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
    }
}

