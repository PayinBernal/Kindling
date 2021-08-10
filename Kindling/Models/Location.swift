//
//  Location.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation

struct Location: Codable {
    let city: String
    let state: String
    let country: String
    let coordinates: Coordinates
    
    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }
}
