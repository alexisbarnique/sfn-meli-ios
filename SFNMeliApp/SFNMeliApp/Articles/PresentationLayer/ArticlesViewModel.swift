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
    
//    func testArticles() {
//        let url = "https://api.spaceflightnewsapi.net/v4/articles/"
//        isLoading = true
//        errorMessage = nil
//        AF.request(url, method: .get).responseDecodable(of: Articles.self) { response in
//            self.isLoading = false
//            debugPrint(response)
//            switch response.result {
//            case .success(let articles):
//                self.articles = articles.results
//            case .failure(let error):
//                print(" error", error)
//                self.errorMessage = error.localizedDescription
//            }
//        }
//    }
}
