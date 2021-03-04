//
//  AdminUserView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-01.
//

import Foundation
import SwiftUI
import MapKit

struct AdminUserView: View {
    //let listOfUserNames: [String]
    @ObservedObject var firebaseMdel = FirebaseModel()
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "person", "gear"]
    
    @State var mapView: MapNav
    @State var currentUser: UserDataModel
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                switch selectedIndex {
                case 0:
                    NavigationView {
                        mapView
                    }
                case 1:
                    NavigationView {
                        SearchView()
                        //Text("Page is under cunstruction")
                    }
                case 2:
                    NavigationView {
                        UnderConstructionView()
                    }
                case 3:
                    NavigationView {
                        ProfileViewSheet()
                            .navigationTitle("Din profil")
                        
                        //DisplayBusinessSheet(location: pressedLocation!, user: pressedUser!)
                    }
                    
                case 4:
                    NavigationView {
                        SettingsView()
                    }
                default:
                    NavigationView {
                        Text("Page is under cunstruction")
                    }
                    
                }
                
            }
            Divider()
                .padding(.bottom, 10)
            
            HStack {
                ForEach(0..<5) {num in
                    Button(action: {
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        Image(systemName: tabBarImageNames[num])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(selectedIndex == num ? ColorManager.darkPink : .init(white: 0.8))
                            .padding(.bottom, 8)
                        Spacer()
                    })
                }
                
            }
        }.onAppear{
            print("Admin User View map person list: \(mapView.listOfLocations.count)")
        }
        
    }
}

struct AdminUserView_Previews: PreviewProvider {
    static var previews: some View {
        var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.4285,
                                           longitude: 17.9512),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        var listOfLocations = [User]()
        
        let listOfNames = ["Nicole", "Sara", "Joakim", "Paul", "Brian", "Brielle", "Anna-lynn"]
        
        let businessUser = BusinessUserData(
            aboutMe: "Älskar burgare",
            certifiedIn: "Naglar",
            productType: "Naglar, fransar och fillers",
            socialMedia: "@nailsbyhannah")
        
        let user = UserDataModel(
            id: "",
            businessAccount: true,
            businessUser: businessUser,
            email: "",
            name: "")
        
        
        AdminUserView(
            mapView: MapNav.init(region: region, listOfLocations: listOfLocations),
            currentUser: user)
    }
}
