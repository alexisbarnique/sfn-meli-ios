//
//  MockManager.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 28/04/2025.
//

import Foundation


class MockManager {
    static let shared = MockManager()
    
    private init() {}
    
    private func loadJSONFile(_ filename: String) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("File not found")
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            fatalError("Error loading or parsing JSON: \(error)")
        }
    }
    
    func getArticleListMock() -> Articles? {
        guard let json = loadJSONFile("NewsListMock") else {
            fatalError("Error load json")
        }
        
        do {
            let mock = try JSONDecoder().decode(Articles.self, from: json)
            return mock
        } catch {
            fatalError("Error serialization")
        }
    }
    
    func getArticleMock() -> Article? {
        guard let json = loadJSONFile("ArticleMock") else {
            fatalError("Error load json")
        }
        
        do {
            let mock = try JSONDecoder().decode(Article.self, from: json)
            return mock
        } catch {
            fatalError("Error serialization")
        }
    }
}

