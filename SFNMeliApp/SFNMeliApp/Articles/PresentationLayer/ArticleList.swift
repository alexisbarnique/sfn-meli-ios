//
//  ArticleList.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//

import SwiftUI

struct ArticleList: View {
//    @Environment(ModelData.self) var modelData
//    @State private var showFavoritesOnly = false

//    var filteredLandmarks: [Landmark] {
//        modelData.landmarks.filter { landmark in
//            (!showFavoritesOnly || landmark.isFavorite)
//        }
//    }
    @StateObject private var viewModel = ArticlesViewModel()
    var body: some View {
        NavigationSplitView {
            List {
                //Search here

                ForEach(viewModel.articles) { article in
                    NavigationLink {
                        ArticleDetail(article: article)
                    } label: {
                        ArticleRow(article: article)
                    }
                }
            }
            .onAppear {
                viewModel.loadArticles()
            }
//            .animation(.default, value: filteredLandmarks)
//            .navigationTitle("Launchs")
        } detail: {
            Text("Select an item")
        }
    }
}
