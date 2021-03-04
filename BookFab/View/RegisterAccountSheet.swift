//
//  RegisterAccountSheet.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-05.
//

import Foundation
import Firebase
import SwiftUI
import MapKit

enum ActiveScreenCoverR: Identifiable {
    case businessAccountScreen, userView
    
    var id: Int {
        hashValue
    }
}

struct RegisterAccountSheet: View {
    //var db = Firestore.firestore()
    @ObservedObject var firebaseModel = FirebaseModel()
    @ObservedObject var userData = UserData()
    
    var locationModel = LocationModel()
    @State var fullScreenCover = false
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.4285,
                                       longitude: 17.9512),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State var nameText = "Name"
    @State var eMailText: String
    @State var password = ""
    @State var passwordConfirmed = ""
    @State var businessAccount = false
    @State var activeScreen: ActiveScreenCoverR?
    
    let registerBtnText = "Registrera"
    let usersCollection = "users"
    let businessAccountText = "Vill du registrera ett företagskonto?"
    
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
                
                /*
                SecureField("Enter password", text: $password)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()*/
                
                SecureField("Enter Password", text: $passwordConfirmed)
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
                        activeScreen = .userView
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
                firebaseModel.readUserLocationFromFirestore()
            }.fullScreenCover(item: $activeScreen) { item in
                switch item {
                case .userView:
                    UserView(
                        mapView: MapNav(
                        region: region,
                        listOfLocations: firebaseModel.listOfLocations!)).environmentObject(userData).environmentObject(firebaseModel)
                case .businessAccountScreen:
                    CreateProfileView(
                        eMailText: eMailText,
                        passwordConfirmed: passwordConfirmed,
                        nameText: nameText,
                        businessAccount: businessAccount).environmentObject(userData).environmentObject(firebaseModel)
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
