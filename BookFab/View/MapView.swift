//
//  MapView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-07.
//

import Foundation
import SwiftUI
import MapKit
import Firebase
import FirebaseFirestoreSwift

enum ScreenCoverActive: Identifiable {
    case mapScreen, registerAccountScreen
    
    var id: Int {
        hashValue
    }
}

struct MapView: View {
    var usersCollection = "locationTest"
    var locationModel = LocationModel()
    var db = Firestore.firestore()
    @State var activeScreen: ActiveScreenCover?
    
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
    
    @State var locations = [
        Location(name: "", latitude: 59.4281, longitude: 17.9509),
        Location(name: "", latitude: 59.4289, longitude: 17.9513),
        Location(name: "", latitude: 59.4275, longitude: 17.9516),
        Location(name: "", latitude: 59.4284, longitude: 17.9522)
    ]
    @State private var listOfLocations = [User]()
    
    //@Published private var listOfLocations = [Location]()

    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                annotationItems: listOfLocations) { location in
                
                //För varje plats har vi en marker
                //MapPin(coordinate: location.coordinate)
                //Ett annat utseende än den övre
                //MapMarker(coordinate: location.coordinate)
                
                //eget utseende för vår marker
                //anchorPoint är vart vi fäster coordinaterna på dem som finns placeras längst ner i mitten
                MapAnnotation(coordinate: location.userLocation!.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                    Image(systemName: "rhombus")
                        .resizable()
                        .frame(width: 25, height: 35)
                        .onTapGesture(count: 1, perform: {
                            print("Klick")
                            activeScreen = .registerAccountScreen
                                    })

                }
            }
            
        }.onAppear {
            //setRegion(coordinate)
            locationModel.askForPermission()
            readUserLocationFromFirestore()
        }.sheet(item: $activeScreen) { item in
            switch item {
            case .mapScreen:
                MapView.init()
            case .registerAccountScreen:
                RegisterAccountSheet(eMailText: "hello det funkar")
                
            }
        }
        
    }
    
    func readUserLocationFromFirestore(){
        print("Nu kommer vi in i funktionen")
        db.collection(usersCollection).addSnapshotListener() { (snapshot, err) in
            if let err = err {
                //print("Error in getting documents \(err)")
            } else {
                listOfLocations.removeAll()
                for document in snapshot!.documents {
                    
                    let result = Result {
                        //Här omvandlar vi från dictionary till en item
                        try document.data(as: User.self) 
                    }
                    //Resultatet av omvandlingen bestämmer vad vi får ut
                    switch result {
                    case .success(let item):
                        //Om omvandlingen är en sucsess får vi itemet
                        //print("Omvandlingen va en sucsess")
                        //Kollar om itemet är nil
                        if let item = item{
                            //print("Item: \(item)")
                            listOfLocations.append(item)
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        //är omvandlingen en faliure
                        print("Error decoding item: \(error)")
                    }
                }
            }
            
            for user in listOfLocations {
                print("ANVÄNDARE: \(user)")
            }
        }
    }
    
    /*func addPin() {
        //let newPlace = Place(name: "Bike", latitude: 37.33233141, longitude: -122.03121816)
        //lägger till en pin där vi är just nu
        if let location = locationModel.location {
            let newPlace = Location(name: "HERE", latitude: location.latitude, longitude: location.longitude)
            locations.append(newPlace)
        }
    }*/

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
