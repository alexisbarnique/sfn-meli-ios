//
//  ArticleList.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//
//  A view showing a list of articles.

import SwiftUI

struct ArticleList: View {
    @StateObject private var viewModel = ArticlesViewModel()
    @State private var searchText = ""
    
    var filteredNews: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(filteredNews) { article in
                    NavigationLink {
                        ArticleDetail(id: String(article.id))
                    } label: {
                        ArticleRow(article: article)
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("News")
            
        } detail: {
            Text("Click for more info")
        }
        .searchable(text: $searchText)
        .onAppear {
            viewModel.loadArticles()
        }
    }
}
