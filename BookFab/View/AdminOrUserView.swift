//
//  AdminOrUserView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-09.
//

import Foundation
import SwiftUI

enum UserType: Identifiable {
    case businessUser, customerUser
    
    var id: Int {
        hashValue
    }
}

struct AdminOrUserView: View {
    @State private var selectedMenuIndex = 0
    @State var isAdminOrUser: UserType
    
    var body: some View {
        VStack(alignment: .trailing) {
            VStack {
                HStack {
                    Button(action: {
                        //changeUserTypeOnClick()
                    }, label: {
                        Text("Swap business/customer")
                    })
                }
                
                switch isAdminOrUser {
                
                case .businessUser:
                    
                    switch selectedMenuIndex {
                    case 0:
                        Text("Map BusinessUser")
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
            .background(Color(.white))
            
            HStack(alignment: .bottom) {
                if isAdminOrUser == UserType.customerUser {
                    TabBarUser(selectedMenuIndex: $selectedMenuIndex)
                } else if isAdminOrUser == UserType.businessUser {
                    TabBarUser(selectedMenuIndex: $selectedMenuIndex)
                }
            }
            .background(Color(.white))
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

struct UnderConstructionVieww: View {
    var body: some View {
        HStack {
            Text("Page is under construction")
                .foregroundColor(.black)
        }
    }
}

struct TabBarUser: View {
    
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "gear"]
    @Binding var selectedMenuIndex: Int
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            ForEach(0 ..< 4) { num in
                
                Button(action: {
                    
                    selectedMenuIndex = num
                    print(selectedMenuIndex)
                    
                }, label: {
                    
                    Image(systemName: tabBarImageNames[num])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    
                })
            }
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 0, leading: 0, bottom: 15, trailing: 0))
        
    }
}

struct TabBarAdmin: View {
    
    let tabBarImageNames = ["map", "magnifyingglass", "bookmark", "person", "gear"]
    @Binding var selectedMenuIndex: Int
    
    var body: some View {
        
        HStack(spacing: 20) {
            
            ForEach(0 ..< 5) { num in
                
                Button(action: {
                    
                    selectedMenuIndex = num
                    print(selectedMenuIndex)
                    
                }, label: {
                    
                    Image(systemName: tabBarImageNames[num])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    
                })
            }
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.init(top: 0, leading: 0, bottom: 15, trailing: 0))
        
    }
}
