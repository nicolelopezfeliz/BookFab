//
//  LocationModel.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-08.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    
    //Måste overrida init för vi ärver från NSObject
    override init(){
        //Kallar på NSObjects init först
        super.init()
        //Manager delegerar ut ansvaret till oss själva, self
        manager.delegate = self
    }
    
    func askForPermission() {
        manager.requestWhenInUseAuthorization()
        //Säger till managern att starta uppdateringar
        //Vi har delegerat ansvret till vår manager och locationManager func kmr köras varje gång
        //den upptäcker att det skett en förändring i plats
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //När det har skett en förändring i plats så kmr våran location ha förändrats
        location = locations.first?.coordinate
        //print("Location updated \(location)")
    }
}
