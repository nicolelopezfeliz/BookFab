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

enum ActiveFullScreen: Identifiable {
    case adminView, userView
    
    var id: Int {
        hashValue
    }
}

struct MapView: View {
    @EnvironmentObject var firebaseModel: FirebaseModel
    @EnvironmentObject var userData: UserData
    
    @State var activeScreen: ScreenCoverActive?
    @State var activeFullScreen: ActiveFullScreen?
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State var pressedLocation: Location? = nil
    @State var pressedUser: User? = nil
    @State var selectedIndex = 0
    @State var fullScreen = true
    @State var currentUser: UserDataModel? = nil
    
    var usersCollection = "users/admin/"
    var locationModel = LocationModel()
    var db = Firestore.firestore()
    var auth = Firebase.Auth.auth()
    
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "person", "gear"]
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
        }.onAppear {
            locationModel.askForPermission()
            
            if userData.isUserAdmin == true {
                activeFullScreen = .adminView
                currentUser = userData.currUserData
            } else {
                activeFullScreen = .userView
                firebaseModel.getCurrentUserInfo(userType: "user")
            }
            
            if let currentUserData = userData.userDocRef {
                
            currentUserData.addSnapshotListener{ documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    guard let data = document.data() else {
                        print("Document data was empty.")
                        return
                    }
                    try! self.userData.currUserData = document.data(as: UserDataModel.self)
                }
            }
            
        }.sheet(item: $activeScreen) { item in
            switch item {
            case .profileView:
                MapView()
            
            case .mapScreen:
                MapView()
                
            case .displayBusinessSheet:
                if let pressedUser = pressedUser {
                    DisplayBusinessSheet(user: pressedUser)
                }
            }
        }
        .fullScreenCover(item: $activeFullScreen) { item in
            switch item {
            case .adminView:
                if let currentUser = userData.currUserData {
                AdminUserView()
                }

            case .userView:
                UserView()
            }
            
        }
        .ignoresSafeArea()
        
    }
    
    /*private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.4285,
                                           longitude: 17.9512),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }*/
}

struct MapNav: View {
    @EnvironmentObject var firebaseModel: FirebaseModel
    @EnvironmentObject var userData: UserData
    
    @State var region: MKCoordinateRegion
    @State var pressedLocation: Location? = nil
    @State var pressedUser: User? = nil
    @State var activeScreen: ScreenCoverActive?
    
    var body: some View {
        VStack{
            if let firebaseListOfLocations = firebaseModel.listOfLocations {
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    annotationItems: firebaseListOfLocations) { location in
                    
                    //Every place has a marker
                    //anchorPoint is where we attatch the coordinates to the annotation
                    MapAnnotation(coordinate: location.userLocation!.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundColor(ColorManager.darkPink)
                            .frame(width: 11, height: 30)
                            .onTapGesture(count: 1, perform: {
                                self.pressedLocation = location.userLocation!
                                self.pressedUser = location
                                print("Location name: \(location.userLocation!.id)")
                                activeScreen = .displayBusinessSheet
                            })
                        
                    }
                }.ignoresSafeArea()
            }
        }.sheet(item: $activeScreen) { item in
            switch item {
            case .profileView:
                MapView()
            
            case .mapScreen:
                MapView()
                
            case .displayBusinessSheet:
                if let pressedUser = pressedUser {
                    DisplayBusinessSheet(user: pressedUser)
                }
            }
        }
        .onAppear{
            print("LOCATIONS: \(firebaseModel.listOfLocations!.count)")
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
