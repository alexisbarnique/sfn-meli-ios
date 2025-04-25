//
//  SFNArticlesServices.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//

import Foundation
import Alamofire

class SFNArticlesServices {

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
    
    static let shared = SFNArticlesServices()

        private init() {}

        func fetchArticles(completion: @escaping (Result<Articles, AFError>) -> Void) {
            let url = "https://api.spaceflightnewsapi.net/v4/articles/"

            AF.request(url, method: .get)
                .validate() // Ensures the response has a valid status code
                .responseDecodable(of: Articles.self) { response in
                    switch response.result {
                    case .success(let articles):
                        completion(.success(articles))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
    
    
}
