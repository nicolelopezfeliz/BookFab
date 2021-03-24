//
//  AdminOrUserView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-09.
//

import Foundation
import SwiftUI
import MapKit

enum UserType: Identifiable {
    case businessUser, customerUser
    
    var id: Int {
        hashValue
    }
}

struct AdminOrUserView: View {
    @State private var selectedMenuIndex = 0
    @State var isAdminOrUser: UserType
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.4285,
                                       longitude: 17.9512),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        VStack(spacing: 0) {
            VStack() {
                
                
                switch isAdminOrUser {
                
                case .businessUser:
                    
                    switch selectedMenuIndex {
                    case 0:
                        MapView(region: region)
                    case 1:
                        Text("Search BusinessUser")
                    case 2:
                        UnderConstructionView()
                    case 3:
                        Text("Profile BusinessUser")
                    case 4:
                        Text("Settings BusinessUser")
                    default:
                        UnderConstructionView()
                    }
                    
                case .customerUser:
                    
                    switch selectedMenuIndex {
                    case 0:
                        Text("Map Customer")
                    case 1:
                        Text("Search Customer")
                    case 2:
                        UnderConstructionView()
                    case 3:
                        Text("Settings Customer")
                    default:
                        UnderConstructionView()
                    }
                    
                default:
                    UnderConstructionView()
                }
            
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 75)
            
            HStack(alignment: .bottom) {
                if isAdminOrUser == UserType.customerUser {
                    TabBarUser(selectedMenuIndex: $selectedMenuIndex)
                } else if isAdminOrUser == UserType.businessUser {
                    TabBarAdmin(selectedMenuIndex: $selectedMenuIndex)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 50)
    }
    
    private func changeUserTypeOnClick() {
        if isAdminOrUser == UserType.customerUser {
            isAdminOrUser = UserType.businessUser
        } else if isAdminOrUser == UserType.businessUser {
            isAdminOrUser = UserType.customerUser
        }
        
    }
}

struct TabBarUser: View {
    
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "gear"]
    @Binding var selectedMenuIndex: Int
    
    var body: some View {
        Divider()
            .padding(.bottom, 10)
        
        HStack {
            ForEach(0..<4) {num in
                Button(action: {
                    selectedMenuIndex = num
                    print(selectedMenuIndex)
                }, label: {
                    Spacer()
                    Image(systemName: tabBarImageNames[num])
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(selectedMenuIndex == num ? ColorManager.darkPink : .init(white: 0.8))
                        .padding(.bottom, 24)
                    Spacer()
                })
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 10, leading: 0, bottom: 40, trailing: 0))
    }
}

struct TabBarAdmin: View {
    
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "person", "gear"]
    @Binding var selectedMenuIndex: Int
    
    var body: some View {
        Divider()
            .padding(.bottom, 10)
        HStack {
            ForEach(0..<5) {num in
                Button(action: {
                    selectedMenuIndex = num
                    print(selectedMenuIndex)
                }, label: {
                    Spacer()
                    Image(systemName: tabBarImageNames[num])
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(selectedMenuIndex == num ? ColorManager.darkPink : .init(white: 0.8))
                        .padding(.bottom, 8)
                    Spacer()
                })
            }
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 10, leading: 0, bottom: 40, trailing: 0))
    }
}

struct UnderConstructionVieww: View {
    var body: some View {
        HStack {
            Text("Page is under construction")
                .foregroundColor(.black)
        }
    }
}
