//
//  SFNError.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import Foundation

enum ErrorType {
    case CustomError
    case BackendError
}


final class SFNError: Error {
    
    var code: Int?
    var message: String?
    var type: ErrorType? = .CustomError
    
    init(message: String) {
        self.message = message
        self.type = .CustomError
    }
    
//    init(code: String, message: String) {
//        self.code = code
//        self.message ? message
//        self.type = .CustomError
//    }
}
