//
//  User.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-07.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift

class User : Codable, Identifiable {
    
    @DocumentID var id : String?
    
    var name: String
    var email: String
    var businessAccount: Bool = false
    var userLocation: Location?
    var businessUser: BusinessUserData? = nil
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case businessAccount
        case userLocation
        case businessUser
    }
    
    init(name: String, email: String, productType: String, socialMedia: String, businessAccount: Bool, userLocation: Location, businessUser: BusinessUserData) {
        self.name = name
        self.email = email
       // self.productType = productType
       // self.socialMedia = socialMedia
        self.businessAccount = businessAccount
        self.userLocation = userLocation
        self.businessUser = businessUser
        
        setUserLocation()
    }
    
    func setUserLocation() {
        let locationManager = LocationModel()
        //let newPlace = Place(name: "Bike", latitude: 37.33233141, longitude: -122.03121816)
        //lägger till en pin där vi är just nu
        if let location = locationManager.location{
            
            userLocation = Location(name: "Grannisar",
                                latitude: location.latitude,
                                longitude: location.longitude)
            
        }
    }
}

extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(email)
    }
}
