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


struct MapView: View {
    @EnvironmentObject var firebaseModel: FirebaseModel
    @EnvironmentObject var userData: UserData
    
    @State var region: MKCoordinateRegion
    @State var businessSheetPresented = false
    @State var pressedLocation: Location? = nil
    @State var pressedUser: User? = nil
    
    var locationModel = LocationModel()
    
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
                                print("Pressed Location name: \(pressedLocation)")
                                print("Pressed USer Name \(pressedUser!.name)")
                                print("Pressed USer Name \(pressedUser!)")
                                
                                
                                businessSheetPresented = true
                            })
                        
                    }
                }.ignoresSafeArea()
            }
        }.sheet(item: $pressedUser) { user in
            DisplayBusinessSheet(user: user)
            
        }
        
        /*.sheet(isPresented: $businessSheetPresented) {
            if let pressedUser = pressedUser {
                DisplayBusinessSheet(user: pressedUser)
            }
        }*/
        .onAppear{
            locationModel.askForPermission()
            addUserCollectionListener()
            print("LOCATIONS: \(firebaseModel.listOfLocations!.count)")
            
        }
        
    }
    
    private func addUserCollectionListener(){
        
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
    }
  
}
