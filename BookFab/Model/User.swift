//
//  User.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-07.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift

struct User : Codable, Identifiable {
    
    @DocumentID var id : String?
    
    var name: String
    var email: String
    //var location = Location(name: "", latitude: 0.0, longitude: 0.0)
    var businessAccount: Bool = false
    var userLocation: Location?
    
    init(name: String, email: String, businessAccount: Bool, userLocation: Location) {
        self.name = name
        self.email = email
        self.businessAccount = businessAccount
        self.userLocation = userLocation
        
        setUserLocation()
    }
    
    mutating func setUserLocation() {
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
