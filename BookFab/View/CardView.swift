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
    
    var title: String
    var textContent: String
    
    /*
     let certefiedTitle: String
     let myProductsTitle: String
     let aboutMeTitle: String
     let socialMediaTitle: String*/
    
    var body: some View {
        ZStack() {
            TitleTextCards(
                title: title,
                textImage: image,
                textContent: textContent
            )
            
        }
        
    }
}

struct TitleTextCards: View {
    var title: String
    var textImage: Image
    @State var textContent: String
     
    var body: some View {
         
        VStack(alignment: .leading) {
             
            VStack {
                 
                Text(title)
                    .font(.headline)
                    .foregroundColor(.pink)
             
            }
         
            HStack {
                 
                textImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                 
                Text(textContent)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .padding(10)
                 
            }
             
        }
        .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
         
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
