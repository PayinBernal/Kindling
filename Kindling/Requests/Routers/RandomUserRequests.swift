//
//  RandomUserRequests.swift
//  Kindling
//
//  Created by Eduardo Bernal on 4/08/21.
//

import Foundation

enum RandomUserRequests {
    case getUser
}

extension RandomUserRequests: URLRequestConvertible {
    var baseUrlString: String {
        return "https://randomuser.me/api/"
    }
    
    var method: HTTPMethod {
        switch self {
            case .getUser: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return request()
    }
}
