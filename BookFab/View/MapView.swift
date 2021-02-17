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
    case displayBusinessSheet, mapScreen, profileView
    
    var id: Int {
        hashValue
    }
}

struct MapView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    var usersCollection = "locationTest"
    var locationModel = LocationModel()
    var db = Firestore.firestore()
    @State var activeScreen: ScreenCoverActive?
    
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
    
    @State private var listOfLocations = [User]()
    
    @State var pressedLocation: Location? = nil
    @State var pressedUser: User? = nil
    
    @State var selectedIndex = 0
    
    let tabBarImageNames = ["mappin.and.ellipse", "magnifyingglass", "map", "person.fill", "gear"]
    
    var body: some View {
        VStack(spacing: 0) {
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
                            self.pressedLocation = location.userLocation!
                            self.pressedUser = location
                            print("Location name: \(location.userLocation!.id)")
                            activeScreen = .displayBusinessSheet
                        })
                    
                }
            }
            
            ZStack {
                switch selectedIndex {
                case 0:
                    NavigationView {
                        Text("Hello")
                    }
                
                case 1:
                    NavigationView {
                        Text("Hello")
                    }
                    
                default:
                    NavigationView {
                        Text("Remaining tabs")
                    }
                    
                }
                
            }
            Divider()
                .padding(.bottom, 16)
            
            HStack {
                ForEach(0..<5) {num in
                    Button(action: {
                        if num == 2 {
                            activeScreen = .mapScreen
                        }
                        
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        Image(systemName: tabBarImageNames[num])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(selectedIndex == num ? ColorManager.darkPink : .init(white: 0.8))
                            .padding(.bottom, 24)
                        Spacer()
                    })
                    
                }
            }
            
            
        }.onAppear {
            //setRegion(coordinate)
            locationModel.askForPermission()
            readUserLocationFromFirestore()
            
        }.sheet(item: $activeScreen) { item in
            switch item {
            case .profileView:
                MapView.init()
            
            case .mapScreen:
                MapView.init()
                
            case .displayBusinessSheet:
                if let pressedLocation = pressedLocation {
                    DisplayBusinessSheet(location: pressedLocation, user: pressedUser!)
                }
                /*if let pressedLocation = pressedLocation {
                    DisplayBusinessSheet(location: pressedLocation)
                } else {
                    print("pressed location har inget värde")
                }*/
                
            }
        }
        .ignoresSafeArea()
        
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
