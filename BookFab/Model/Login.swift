//
//  Login.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-04.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Login {
    var db = Firestore.firestore()
    
    func checkIfUserLoggedIn(){
        if Firebase.Auth.auth().currentUser != nil {
            print("DU är inloggad sen tidigare")
        } else {
            print("Ingen användare är inloggad")
        }
    }
    
    func loginUser(email: String, password: String){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, err in

            guard err == nil else {
                print("No account with tis e-mail")
                //If we cant sign in user we show alert
                //Show allert to create account
                return
            }
            
            //Här vill vi komma till nästa vy
            print("Inloggning, sucsess, du är inloggad")
        })
    }
    
    func resetPassword(){
        
    }
    
    func createAccount(email: String, password: String){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, err in
            
            //db.collection(usersCollection).addDocument(data: ["name" : "\(nameText)", "e-mail" : "\(email)"])
            
            guard err == nil else {
                //Show account creation error
                print("Error när du skapade kontot")
                return
            }
        })
        
    }
    
    func logOutUser(){
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("You sucsessfully logged out")
        } catch  {
            print("Error in logging out")
        }
    }
}
