//
//  MapView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-07.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    var locationModel = LocationModel()
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    
    //@Environment(\.presentationMode) var presentationMode
    //var coordinate: CLLocationCoordinate2D
    //@State private var region = MKCoordinateRegion()
    
    //Center är vart vi är
    //Span är hur mycket vi är inzoomade
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.4285,
                                       longitude: 17.9512),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State private var locations = [
        Location(name: "", latitude: 59.4281, longitude: 17.9509),
        Location(name: "", latitude: 59.4289, longitude: 17.9513),
        Location(name: "", latitude: 59.4275, longitude: 17.9516),
        Location(name: "", latitude: 59.4284, longitude: 17.9522)
    ]

    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: locations) { location in
                
                //För varje plats har vi en marker
                //MapPin(coordinate: place.coordinate)
                //Ett annat utseende än den övre
                //MapMarker(coordinate: place.coordinate)
                
                //eget utseende för vår marker
                //anchorPoint är vart vi fäster coordinaterna på dem som finns placeras längst ner i mitten
                MapAnnotation(coordinate: location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    Image(systemName: "rhombus")
                        .resizable()
                        .frame(width: 25, height: 35)
                }
                
                
            }
            
            
            Button(action: {
                addPin()
                print("Pin added")
            }, label: {
                Text("Add Pin")
            })
            
        }.onAppear {
            //setRegion(coordinate)
            locationModel.askForPermission()
        }
        
    }
    
    func addPin() {
        //let newPlace = Place(name: "Bike", latitude: 37.33233141, longitude: -122.03121816)
        //lägger till en pin där vi är just nu
        if let location = locationModel.location {
            let newPlace = Location(name: "HERE", latitude: location.latitude, longitude: location.longitude)
            locations.append(newPlace)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.4285,
                                           longitude: 17.9512),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
