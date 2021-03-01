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
    
    let notYetPostedInfo = "Information is under cunstroction"
    
    
    
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
                    .font(.system(size: 20))
                    .padding()
                
                Text("Certifierad: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                Text("\(user.businessUser?.certifiedIn ?? "\(notYetPostedInfo)")")
                    .padding()
                
                Text("Mina produkter: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                Text("\(user.businessUser?.productType ?? "\(notYetPostedInfo)")")
                    .padding()
                
                Text("Lite om mig: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                Text("\(user.businessUser?.aboutMe ?? "\(notYetPostedInfo)")")
                    .padding()
                
                
                Text("Instagram: ")
                    .font(.system(size: 18))
                    .foregroundColor(ColorManager.darkPink)
                Text("\(user.businessUser?.socialMedia ?? "\(notYetPostedInfo)")")
                    .padding()
                
                
            }
            .padding(.top)
            .frame(width: 360, height: .infinity, alignment: .leading)
        }
    }
}

struct DisplayBusinessSheet_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(
            name: "",
            latitude: 0.0,
            longitude: 0.0)
        
        let businessUser = BusinessUser(
            certifiedIn: "",
            aboutMe: "",
            productType: "",
            socialMedia: "")
        
        let user = User(
            name: "",
            email: "",
            productType: "",
            socialMedia: "",
            businessAccount: true,
            userLocation: location,
            businessUser: businessUser)
        
        DisplayBusinessSheet(location: user.userLocation!, user: user)
    }
}
