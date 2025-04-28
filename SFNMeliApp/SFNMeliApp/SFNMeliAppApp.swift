//
//  SFNMeliAppApp.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//

import SwiftUI

@main
struct SFNMeliAppApp: App {
    var body: some Scene {
        WindowGroup {
            if CommandLine.arguments.contains("UITestMode") {
                let articleList = MockManager.shared.getArticleListMock()
                let article = MockManager.shared.getArticleMock()
                ArticleList(viewModel: ArticlesViewModel(mockListArticle: articleList?.results, mockArticle: article))
            } else {
                ArticleList(viewModel: ArticlesViewModel())
            }
        }
    }
}
