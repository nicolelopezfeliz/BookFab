//
//  SettingsView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-19.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    var listOfSettings = ["lock", "person.circle", "info.circle", "bell"]
    var listOfSettingTitle = ["Sekretess", "Konto", "Om", "Aviseringar" ]
    
    var body: some View {
        ZStack {
            List() {
                ForEach(0..<4) { num in
                    NavigationLink(
                        destination: SettingsView()) {
                        SettingsRow(image: Image(systemName: "\(listOfSettings[num])"), rowText: "\(listOfSettingTitle[num])")
                    }
                }
            }
            .navigationBarTitle("Inställningar")
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
                
                Button(action: {print("Logga ut")
                    
                }, label: {
                    Text("Logga ut")
                })
                
            } .frame(width: 350, height: 300, alignment: .leading)
        }
        
    }
    
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        //@Static let emailText = ""
        
        SettingsView()
    }
}
