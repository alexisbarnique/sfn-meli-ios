//
//  ServiceRequestModel.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import Foundation
import Alamofire

protocol ServiceRequestModelProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
//    var headers: HTTPHeaders { get }
    var timeout: TimeoutRequest { get }
}

struct GenericServiceRequestModel {
    let endPoint: Endpoint
    let method: HTTPMethod
    let queryParams: [String: String]
    let paramObject: Encodable?
//    var customHeaders: HTTPHeaders
    let endPath: String
    var timeout: TimeoutRequest
    
    init(endPoint: Endpoint,
         method: HTTPMethod,
         queryParams: [String: String] = [:],
         paramObject: Encodable? = nil,
         customHeaders: HTTPHeaders = [:],
         endPath: String = "",
         timeout: TimeoutRequest = .medium) {
        self.endPoint = endPoint
        self.method = method
        self.queryParams = queryParams
        self.paramObject = paramObject
//        self.customHeaders = customHeaders
        self.endPath = endPath
        self.timeout = timeout
    }
}

extension GenericServiceRequestModel: ServiceRequestModelProtocol {
    
    var url: String {
        var finalEndpoint = endPath.isEmpty ? endPoint.rawValue : "\(endPoint.rawValue)\(endPath)"
        guard !queryParams.isEmpty else {
            return finalEndpoint
        }
        finalEndpoint = "\(finalEndpoint)"
        for (index, param) in queryParams.enumerated() {
            if index != 0 {
                finalEndpoint = "\(finalEndpoint)&"
            }
            finalEndpoint = "\(finalEndpoint)\(param.key)=\(param.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
        return finalEndpoint
    }
    
    var parameters: [String : Any] {
        return paramObject?.toDictionary ?? [:]
    }
    
}
