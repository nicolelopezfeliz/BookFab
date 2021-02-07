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
    
    @State var nameText = "Name"
    @State var eMailText: String
    @State var password = ""
    @State var passwordConfirmed = ""
    
    let registerBtnText = "Registrera"
    let usersCollection = "users"
    
    
    
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
                
                
                TextEditor(/*"Enter password",*/ text: $password)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                TextEditor(/*"Confirm password",*/ text: $passwordConfirmed)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                Button(action: {
                        /*createAccount(
                            email: self.eMailText,
                            password: self.passwordConfirmed)*/
                    
                    Login().createAccount(email: eMailText, password: passwordConfirmed)
                    
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
                
            }
        }
    }
    
    /*func createAccount(email: String, password: String){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, err in
            
            db.collection(usersCollection).addDocument(data: ["name" : "\(nameText)", "e-mail" : "\(email)"])
            
            guard err == nil else {
                //Show account creation error
                print("Error när du skapade kontot")
                return
            }
        })
        
    }*/
}

struct RegisterAccountSheet_Previews: PreviewProvider {
    static var previews: some View {
        @Static let emailText = ""
        
        RegisterAccountSheet(eMailText: emailText)
    }
}



