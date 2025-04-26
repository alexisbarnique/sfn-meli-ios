//
//  ServiceNetworkManager.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import Foundation
import Alamofire

typealias APIFailureHandler = (SFNError) -> Void
typealias APISuccessHandler = (Any) -> Void

enum TimeoutRequest: TimeInterval {
    case short = 6.0
    case medium = 12.0
    case long = 30.0
}

final class ServiceNetworkManager: SessionDelegate {
    static let sharedInstance = ServiceNetworkManager()
    let configuration = URLSessionConfiguration.default
    var sessionManager = Session()
    
    private init() {
        super.init()
        configuration.timeoutIntervalForRequest = TimeoutRequest.long.rawValue
        configuration.timeoutIntervalForResource = TimeoutRequest.long.rawValue
        configuration.httpShouldSetCookies = false
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        
    }
    
    func call(service serviceUrl: String,
              method: HTTPMethod,
              parameters: [String: Any]?,
              timeout: TimeoutRequest = .medium,
              headers: HTTPHeaders,
              success: APISuccessHandler?,
              failure: APIFailureHandler?,
              emptyBodyResponse: Bool = false) {
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if method == .get || method == .delete {
            encoding = URLEncoding.default
        }
        
        sessionManager.request(serviceUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
            { $0.timeoutInterval = timeout.rawValue }
            .responseJSON { response in
                
            let respHeaders = response.response?.allHeaderFields
            self.checkResponseStatus(domain: serviceUrl, response: response)
            
            switch response.result {
            case .success(let JSON):
                guard let dictionaryData = JSON as? [String : Any] else {
                    failure?(.init(message: "Error dictionary Service"))
                    return
                }
                success?(dictionaryData)
                //                    if emptyBodyResponse {
                //                        success?(dictionaryData.dictionaryForKey("d"))
                //                    } else if !dictionaryData.dictionaryForKey("d").isEmpty {
                //                        success?(dictionaryData.dictionaryForKey("d"))
                //                    } else {
                //                        failure?(SFNError(message: ""))
                //                    }
                
            case.failure(_):
                let statusCode = response.response?.statusCode ?? 0
                if emptyBodyResponse && statusCode >= 200 && statusCode < 300 {
                    success?([:])
                    return
                }
                failure?(SFNError(message: ""))
            }
        }
    }
    
    func callData(service serviceUrl: String,
              method: HTTPMethod,
              parameters: [String: Any]?,
              timeout: TimeoutRequest = .medium,
              headers: HTTPHeaders,
              success: APISuccessHandler?,
              failure: APIFailureHandler?,
              emptyBodyResponse: Bool = false) {
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if method == .get {
            encoding = URLEncoding.default
        }
        
        sessionManager.request(serviceUrl, method: method, parameters: parameters, encoding: encoding, headers: headers)
            { $0.timeoutInterval = timeout.rawValue }
            .validate(statusCode: 200..<300)
            .responseData(emptyResponseCodes: [200, 204, 205]) { response in
                self.checkResponseStatus(domain: serviceUrl, response: response)
                
                switch response.result {
                case .success(let Data):
                    success?(Data)
                case .failure(_):
                    guard let data = response.data,
                          let jsonError = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                        failure?(SFNError(message: ""))
                        return
                    }
                    print(jsonError)
                    failure?(SFNError(message: "Failure service"))
            }
        }
    }
}

private extension ServiceNetworkManager {
    func checkResponseStatus<Value>(domain: String, response: DataResponse<Value, AFError>) {
        guard let statusCode = response.response?.statusCode, statusCode > 400, let data = response.data, let request = response.request else {
            return
        }
        
        do {
            throw NSError(domain: domain, code: 100)
        } catch let error as NSError {
            print("ERROR", error)
        }
    }
}
