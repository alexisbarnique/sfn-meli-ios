//
//  ArticlesViewModel.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//
//  ViewModel to serve data to the Views.

import SwiftUI
import Alamofire


class ArticlesViewModel: ObservableObject {
    @Published var articles: [Article] = [] // List of articles
    @Published var isLoading: Bool = false // Tracks loading status
    @Published var errorMessage: String? // Stores error messages if any
    @Published var article: Article?
    
    
    /// This function obtain the last articles
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
    
    /// This function obtains the details of an article from its id
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
