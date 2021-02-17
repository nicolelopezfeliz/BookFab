//
//  DisplayBusinessSheet.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-15.
//

import Foundation
import SwiftUI

struct DisplayBusinessSheet: View {
    //var businessName: String
    var location: Location
    var user: User
    
    
    
    var body: some View {
        ScrollView {
            BusinessImage(image: Image("nailimage"))
                .ignoresSafeArea(edges: .top)
                .padding(.bottom, -130)
                .offset(y: -130)
            
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("\(user.name)")
                    .foregroundColor(ColorManager.darkPink)
                    .fontWeight(.bold)
                    .padding(.top, 150)
                
                Text("Certifierad: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                    .padding()
                
                Text("Mina produkter:")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                    .padding()
                
                Text("Lite om mig")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                    .padding()
                
                Text("Instagram: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                    .padding()
                
            }.padding()
        }
    }
}

struct DisplayBusinessSheet_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(
            name: "",
            latitude: 0.0,
            longitude: 0.0)
        
        let user = User(
            name: "",
            email: "",
            productType: "",
            socialMedia: "",
            businessAccount: true,
            userLocation: location)
        
        DisplayBusinessSheet(location: user.userLocation!, user: user)
    }
}
