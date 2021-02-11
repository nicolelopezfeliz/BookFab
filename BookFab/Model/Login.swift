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
    var usersCollection = "users"
    var db = Firestore.firestore()
    
    func checkIfUserLoggedIn() -> Bool {
        if Firebase.Auth.auth().currentUser != nil {
            print("DU är inloggad sen tidigare")
            return true
        } else {
            print("Ingen användare är inloggad")
            return false
        }
        print("Error när användaren skulle läsas")
        return false
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
    
    func createAccount(email: String, password: String, name: String){
        var newUser = User(name: "", email: "", businessAccount: false)
        
        print("emejlen: \(email)")
        print("lösenordet: \(password)")
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print("Error in creating account")
                print(error.localizedDescription )
            } else {
                //user registered successfully
                print("Registered sucsessfully")
                print(result)
            }
            
            if let location = LocationModel().location {
                newUser = User(name: "\(newUser.name)",
                               email: "\(newUser.email)",
                               location: Location(name: "HERE", latitude: location.latitude, longitude: location.longitude) ,
                               businessAccount: false)
                
                print("Location: \(location.latitude) : \(location.longitude)")
            }
            
            do {
                _ = try self.db.collection(self.usersCollection).addDocument(data: ["user" : "\(newUser)" /*"name" : "\(name)", "e-mail" : "\(email)"*/])
            } catch {
                print("Error in saving to DB")
            }
            
            print("emejlen: \(email)")
            print("lösenordet: \(password)")
            print("namn: \(name)")
            
            //Creating a user
            
            
            //Om det är et företagskonto skall man lägga till sin location
            
            
        }
        
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
