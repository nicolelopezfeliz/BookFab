//
//  RegisterAccountSheet.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-05.
//

import Foundation
import Firebase
import SwiftUI

struct RegisterAccountSheet: View {
    //var db = Firestore.firestore()
    
    var locationModel = LocationModel()
    @State var fullScreenCover = false
    
    @State var nameText = "Name"
    @State var eMailText: String
    @State var password = ""
    @State var passwordConfirmed = ""
    @State var businessAccount = false
    @State var activeScreen: ActiveScreenCover?
    
    let registerBtnText = "Registrera"
    let usersCollection = "users"
    let businessAccountText = "Vill du registrera ett företagskonto?"
    
    enum ActiveScreenCover: Identifiable {
        case businessAccountScreen, mapScreen
        
        var id: Int {
            hashValue
        }
    }
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Registrera konto")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                    .foregroundColor(ColorManager.darkPink)
                
                TextEditor(text: $nameText)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                
                TextEditor(text: $eMailText)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                
                SecureField("Enter password", text: $password)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                SecureField("Confirm password", text: $passwordConfirmed)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                HStack {
                    Button(action: {
                        print("Skapa företagskonto")
                        
                        toggle(item: businessAccount)
                    }, label: {
                        Image(systemName: businessAccount ? "checkmark.square" : "square")
                        
                    })
                    
                    Text(businessAccountText)
                        .font(.system(size: 13))
                        .foregroundColor(ColorManager.darkPink)
                        .frame(width: 200, height: 40, alignment: .leading)
                    
                }
                
                Button(action: {
                    /*Login().createAccount(
                        email: eMailText,
                        password: passwordConfirmed,
                        name: nameText,
                        businessAccount: businessAccount
                    )*/
                    
                    if businessAccount == true {
                        activeScreen = .businessAccountScreen
                    } else {
                        let businessUser = BusinessUser(
                            certifiedIn: "",
                            aboutMe: "",
                            productType: "",
                            socialMedia: "")
                        
                        Login().createAccount(
                            email: eMailText,
                            password: passwordConfirmed,
                            name: nameText,
                            businessAccount: businessAccount,
                            businessUserAssets: businessUser
                        )
                        activeScreen = .mapScreen
                    }
                    
                    
                }, label: {
                    Text(registerBtnText)
                        .font(.title3)
                        .frame(width: 160,
                               height: 40,
                               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(ColorManager.darkPink)
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(5.0)
                })
                
                Spacer()
                
            }.onAppear(){
                locationModel.askForPermission()
            }.fullScreenCover(item: $activeScreen) { item in
                switch item {
                case .mapScreen:
                    MapView.init()
                case .businessAccountScreen:
                    ProfileViewSheet(
                        eMailText: eMailText,
                        passwordConfirmed: passwordConfirmed,
                        nameText: nameText,
                        businessAccount: businessAccount)
                    //MapView.init()
                    //DisplayBusinessSheet(location: <#T##Location#>, user: <#T##User#>)
                    //RegisterAccountSheet(eMailText: "\(emailText)")
                    
                }
            }
        }
    }
    
    private func toggle(item: Bool){
        //Item.done får det vrdet den inte har
        //item.done = !item.done
        //.toggle() gör samma sak som att ge den det motsatta värdet
        businessAccount.toggle()
        
        //Har vi ändrat något värde så måste vi säga till vår viewContext att den ändras så att den
        //kan sparar, vi sparar vår viewContext
        //Vi har gjort en förändring då sparar vi på en gång
        do {
            //try viewContext.save()
        } catch {
            print("Eror toggling object")
        }
    }
}

struct RegisterAccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        @Static let emailText = ""
        
        RegisterAccountSheet(eMailText: emailText)
    }
}



