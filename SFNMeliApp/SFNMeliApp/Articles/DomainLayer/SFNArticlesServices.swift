//
//  SFNArticlesServices.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//
//  Class to call the API.

import Foundation
import Alamofire

class SFNArticlesServices {
    static let shared = SFNArticlesServices()
    
    private init() {}
    
    /// Function to load the last articles from Spaceflight News API
    /// - Parameter completion: Response from the API
    func fetchArticles(completion: @escaping (Result<Articles, AFError>) -> Void) {
        AF.request(Endpoint.articles.rawValue, method: .get)
            .validate()
            .responseDecodable(of: Articles.self) { response in
                switch response.result {
                case .success(let articles):
                    completion(.success(articles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    
    /// Function to obtain the details of an article from Spaceflight News API
    /// - Parameters:
    ///   - id: id of article
    ///   - completion: Response from the API
    func fetchArticle(id: String, completion: @escaping (Result<Article, AFError>) -> Void) {
        let url = Endpoint.articles.rawValue + "\(id)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Article.self) { response in
                switch response.result {
                case .success(let article):
                    completion(.success(article))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

// 
//    private let baseService = BaseService()
//
//
//    func fetchArticles(model: GenericServiceRequestModel, completion: @escaping (Result<[Article], SFNError>) -> ()) {
//        baseService.call(model: model) { (response: Result<[Article], SFNError>) in
//            response.onSuccess { (model) in
//                completion(response)
//            }.onFailure { error in
//                completion(.failure(error))
//            }
//        }
//    }
