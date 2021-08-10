//
//  RandomUser.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation

struct RandomUser: Codable {
    
    let gender: String
    let email: String
    let phone: String
    let cell: String
    let nat: String
    
    let name: Name
    let picture: Picture
    let login: Login
    let location: Location
    let dob: DayOfBirth
    
    var fullName: String {
        "\(name.title) \(name.first) \(name.last)"
    }
    
    var age: Int {
        dob.age
    }
    
    var username: String {
        login.username
    }
    
    var latitude: String {
        location.coordinates.latitude
    }
    
    var longitude: String {
        location.coordinates.longitude
    }
    
    var city: String {
        location.city
    }
    
    var state: String {
        location.state
    }
    
    var country: String {
        location.country
    }

}
