//
//  ArticlesViewModel.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//
//  ViewModel to serve data to the Views.

import SwiftUI
import Alamofire

enum NewsState: Equatable {
    case success
    case loading
    case error(String)
}

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var article: Article?
    @Published var state: NewsState = .loading
    
    
    init(mockListArticle: [Article]? = nil, mockArticle: Article? = nil) {
        if let mockList = mockListArticle, let article = mockArticle {
            self.articles = mockList
            self.article = article
        }
    }
    
    /// This function obtain the last articles
    func loadArticles() {
        SFNArticlesServices.shared.fetchArticles { [weak self] result in
            DispatchQueue.main.async {
                self?.state = .loading
                switch result {
                case .success(let articles):
                    self?.articles = articles.results
                    self?.state = .success
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    /// This function obtains the details of an article from its id
    func loadArticle(id: String) {
        SFNArticlesServices.shared.fetchArticle(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.state = .loading
                switch result {
                case .success(let article):
                    self?.article = article
                    self?.state = .success
                case .failure(let error):
                    self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
}
