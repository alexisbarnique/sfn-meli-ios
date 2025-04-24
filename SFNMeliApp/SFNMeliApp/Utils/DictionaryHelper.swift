//
//  DictionaryHelper.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    func dictionaryForKey (_ key : Key) -> [String: Any] {
        if let value = self[key] as? [String: Any] {
            return value
        }
        return [String: Any]()
    }
}


extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
