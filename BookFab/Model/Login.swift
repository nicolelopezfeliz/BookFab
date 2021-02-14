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
   // @State var isBusinessAccount = false
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    var locationModel = LocationModel()
    
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
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print("Error in creating account")
                print(error.localizedDescription )
            } else {
                //user registered successfully
                print("Registered sucsessfully")
                print(result)
                
                
                let userLocation = Location(name: "", latitude: 59.4281, longitude: 17.9509)
                
                let newUser = User(name: "\(name)",
                                email: "\(email)",
                                businessAccount: true,
                                userLocation: userLocation)
                
                saveUserToFirestore(user: newUser)
                /*do {
                    _ = try db.collection(usersCollection).addDocument(from: user)
                } catch {
                    print("Error in saving to DB")
                }*/
            }
            
            print("emejlen: \(email)")
            print("lösenordet: \(password)")
            print("namn: \(name)")
            
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
    
    func saveUserToFirestore(user: User){
        do {
            _ = try db.collection(usersCollection).addDocument(from: user)
        } catch {
            print("Error in saving to DB")
        }
    }
    
    func readUserFromFirestore(){
        
    }
}
