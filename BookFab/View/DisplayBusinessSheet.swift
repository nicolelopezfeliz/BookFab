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
    //var location: Location
    @State var user: User
    
    private let certefiedTitle = "Certifierad"
    private let myProductsTitle = "Mina Produkter"
    private let aboutMeTitle = "Lite om mig"
    private let socialMediaTitle = "Instagram"
    
    let notYetPostedInfo = "Information is under cunstroction"
    
    let heightFourth = UIScreen.main.bounds.height/4
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            ScrollView {
                
                Image("nailimage")
                    .resizable()
                    .frame(height: heightFourth)
                    .ignoresSafeArea(edges: .top)

                
                if let businessUser = user.businessUser {
                    Text("\(user.name)")
                        .foregroundColor(ColorManager.darkPink)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding()

                    TitleText(
                        title: certefiedTitle, textImage: Image(systemName: "link"),
                        textContent: businessUser.certifiedIn)
                        .padding(.bottom, 4)
                    
                    TitleText(
                        title: myProductsTitle, textImage: Image(systemName: "wand.and.stars"),
                        textContent: businessUser.productType)
                        .padding(.bottom, 4)
                    
                    TitleText(
                        title: aboutMeTitle, textImage: Image(systemName: "heart.text.square"),
                        textContent: businessUser.aboutMe)
                        .padding(.bottom, 4)
                    
                    TitleText(
                        title: socialMediaTitle, textImage: Image(systemName: "link"),
                        textContent: businessUser.socialMedia)
                        .padding(.bottom, 4)
                }
                
            }.frame(height: heightFourth * 3)
        }
    }
}
