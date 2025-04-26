//
//  ArticlesViewModel.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import SwiftUI
import Alamofire

class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = [] // List of articles
    @Published var isLoading: Bool = false // Tracks loading status
    @Published var errorMessage: String? // Stores error messages if any
    @Published var article: Article?
    
    func loadArticles() {
        isLoading = true
        errorMessage = nil
        
        SFNArticlesServices.shared.fetchArticles { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let articles):
                    self?.articles = articles.results
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadArticle(id: String) {
        isLoading = true
        errorMessage = nil
        
        SFNArticlesServices.shared.fetchArticle(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let article):
                    self?.article = article
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
