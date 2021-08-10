//
//  RandomUserViewModel.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation
import UIKit.UIImage
import CoreLocation.CLLocation

struct CardViewModel {
    let username: String
    let name: String
    let email: String
    let phone: String
    let cell: String
    let dob: String
    let age: Int
    let picture: String
    let coordinates: CLLocationCoordinate2D
    let city: String
    let state: String
    let country: String
    let nat: String
    
    var flag: String {
        flag(country: nat)
    }
    
    var formattedDOB: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        
        if let dobDate = formatter.date(from: dob) {
            let legibleFormatter = DateFormatter()
            legibleFormatter.dateFormat = "MMMM d"
            
            return legibleFormatter.string(from: dobDate)
        } else {
            return dob
        }
    }
    
    init(user: RandomUser) {
        self.username = user.username
        self.name = user.fullName
        self.email = user.email
        self.phone = user.phone
        self.cell = user.cell
        self.dob = user.dob.date
        self.age = user.age
        self.picture = user.picture.large
        self.city = user.city
        self.state = user.state
        self.country = user.country
        self.nat = user.nat
        
        if let lat = Double(user.latitude),
           let lon = Double(user.longitude) {
            self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        } else {
            self.coordinates = kCLLocationCoordinate2DInvalid
        }
    }
    
    private func flag(country: String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
