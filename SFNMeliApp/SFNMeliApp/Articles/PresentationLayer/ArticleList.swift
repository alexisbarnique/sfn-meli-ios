//
//  ArticleList.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//
//  A view showing a list of articles.

import SwiftUI

struct ArticleList: View {
    @StateObject var viewModel: ArticlesViewModel
    @State private var searchText = ""
    
    var filteredNews: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .success:
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
                    .searchable(text: $searchText)
                    .accessibilityIdentifier("searchBar")
                    
                } detail: {
                    Text("Click for more info")
                }
            case .loading:
                ProgressView()
                .accessibilityIdentifier("Loading view")
            case .error:
                VStack {
                    Text("Cant show the news in this moment, Please retry!")
                    Button(action: {
                        viewModel.loadArticles()
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .navigationTitle("Error")
            }
        }.onAppear {
            viewModel.loadArticles()
        }
    }
}
