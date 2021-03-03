//
//  CardView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-03.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var user: UserData
    let image = Image(systemName: "heart.text.square")
    
    let certefiedTitle = "Certifierad"
    let myProductsTitle = "Mina Produkter"
    let aboutMeTitle = "Lite om mig"
    let socialMediaTitle = "Imstagram"
    
    var body: some View {
        VStack() {
            //if let user = user {
            if let businessUser = user.currUserData?.businessUser {
                
                TitleTextCards(
                    title: certefiedTitle,
                    textContent: businessUser.certifiedIn,
                    textImage: image)
                
                TitleTextCards(
                    title: myProductsTitle,
                    textContent: businessUser.productType,
                    textImage: image)
                
                TitleTextCards(
                    title: aboutMeTitle,
                    textContent: businessUser.aboutMe,
                    textImage: image)
                
                TitleTextCards(
                    title: socialMediaTitle,
                    textContent: businessUser.socialMedia,
                    textImage: image)
            }
            
            // }
        }.onAppear{
            print("Card View User \(user.currUserData)")
        }
    }
}

struct TitleTextCards: View {
    var title: String
    @State var textContent: String
    var textImage: Image
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
        }.frame(width: UIScreen.main.bounds.width)
        
        Spacer()
            
        HStack {
            textImage
            Spacer()
            
            Text(textContent)
                .font(.system(size: 14))
                .padding(.trailing, 20)
                .foregroundColor(.black)
        }
            .onAppear{
                print("Text content \(textContent)")
            }
            
        
    }
}
/*
 struct CardView_Previews: PreviewProvider {
 static var previews: some View {
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
 
 CardView(user: user)
 .previewLayout(.fixed(width: 400, height: 60))
 }
 }*/
