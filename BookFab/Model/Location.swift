//
//  Location.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-09.
//

import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    
    //We get the longitude and latitude back
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    /*func defaultData(){
        var locations = [
            Location(name: "Granne", latitude: 37.33233141, longitude: -122.032),
            Location(name: "Granne", latitude: 37.33233141, longitude: -122.030),
            Location(name: "Granne", latitude: 37.33233141, longitude: -122.029)
        ]
    }*/
    
}
