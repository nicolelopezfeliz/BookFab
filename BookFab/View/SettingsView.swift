//
//  SettingsView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-19.
//

import Foundation
import SwiftUI

enum ActiveScreen: Identifiable {
    case contentView
    
    var id: Int {
        hashValue
    }
}

struct SettingsView: View {
    @State var activeScreen: ActiveScreen?
    
    var listOfSettingss = [
        SettingsViewModel(title: "Sekretess", imageName: "lock"),
        SettingsViewModel(title: "Konto", imageName: "person.circle"),
        SettingsViewModel(title: "Om", imageName: "info.circle"),
        SettingsViewModel(title: "Aviseringar", imageName: "bell")
    ]
    var listOfSettings = ["lock", "person.circle", "info.circle", "bell"]
    var listOfDestinations = [UnderConstructionView(), ProfileViewSheet(), UnderConstructionView(), UnderConstructionView()] as [Any]
    var listOfSettingTitle = ["Sekretess", "Konto", "Om", "Aviseringar" ]
    
    var body: some View {
        
        ZStack {
            List(listOfSettingss) { setting in
                NavigationLink(destination: EditProfileView()) {
                    
                    HStack {
                        SettingsRow(image: Image(systemName: setting.imageName) , rowText: setting.title)
                    }
                }
            } .navigationBarTitle("Inställningar")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: SettingsView(),
                                    label: {
                                        Image(systemName: "person.circle")
                                    }))
            
            
            VStack(alignment: .leading) {
                
                Button(action: {print("inloggningsuppgifter")
                    
                }, label: {
                    Text("Inloggningsuppgifter")
                })
                
                Spacer()
                    .frame(height: 5)
                
                Button(action: {
                    print("Logga ut")
                    Login().logOutUser()
                    activeScreen = .contentView
                    
                    
                }, label: {
                    Text("Logga ut")
                })
                
            } .frame(width: 350, height: 300, alignment: .leading)
        }.fullScreenCover(item: $activeScreen) { item in
            switch item {
            case .contentView:
                ContentView()
                
            }
        }

    }
    
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        //@Static let emailText = ""
        
        SettingsView()
    }
}
