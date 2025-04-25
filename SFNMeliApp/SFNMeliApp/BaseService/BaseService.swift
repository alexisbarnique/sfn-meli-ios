//
//  BaseService.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//
import Foundation
import Alamofire

protocol BaseServiceProtocol {
    func call<T: Decodable>(model: ServiceRequestModelProtocol,completion: @escaping (Swift.Result<T, SFNError>) -> Void)
}

class BaseService {
    func call(_ serviceUrl: String, method: HTTPMethod, operationType: String = "", headers: HTTPHeaders = [:], parameters: [String: Any]?, timeout: TimeoutRequest = .medium, success: @escaping ([String: Any]) -> Void, failure: @escaping (SFNError) -> Void, emptyBodyResponse: Bool = false) {
        var customHeader = headers
        
        if headers.isEmpty {
            customHeader = ["accept": "application/json"]
        }
        
        ServiceNetworkManager.sharedInstance.call(service: serviceUrl,
                                                  method: method,
                                                  parameters: parameters ?? [:],
                                                  timeout: timeout,
                                                  headers: customHeader,
                                                  success: { result in
            if let response = result as? [String: Any] {
                success(response)
            } else {
                failure(SFNError(message: "Error parse response"))
            }
        }, failure: { error in
            failure(error)
        }, emptyBodyResponse: emptyBodyResponse)
    }

}

extension BaseService: BaseServiceProtocol {
    func call<T: Decodable>(model: ServiceRequestModelProtocol,
                            completion: @escaping (Swift.Result<T, SFNError>) -> Void) {
        call(model.url,
             method: model.method,
             parameters: model.parameters,
             timeout: model.timeout,
             success: { response in
            let decoder = JSONDecoder()
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let value = try decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(.init(message: "Error dictionary Service")))
            }
        }, failure: { error in
            completion(.failure(error))
        }, emptyBodyResponse: false)
    }
}

extension Swift.Result {
    @discardableResult func onSuccess(_ handler: (Success) -> Void) -> Self {
        guard case let .success(value) = self else {
            return self
        }
        handler(value)
        return self
    }
    
    @discardableResult func onFailure(_ handler: (Failure) -> Void) -> Self {
        guard case let .failure(error) = self else {
            return self
        }
        handler(error)
        return self
    }
}
