//
//  APIError.swift
//  Kindling
//
//  Created by Eduardo Bernal on 4/08/21.
//

import Foundation

struct APIError: Error {
    var apiName: String = "Error"
    let code: String
    let message: String
    
    static let badRequest = APIError(code: "-1", message: "Bad request")
    static let badResponse = APIError(code: "-1", message: "Could not parse response")
}

extension Error {
    var code: Int {
        return (self as NSError).code
    }
}
