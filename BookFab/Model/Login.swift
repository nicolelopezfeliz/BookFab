//
//  Login.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-04.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI


class Login : ObservableObject {
    
   // @State var isBusinessAccount = false
    private var listOfLocations = [Location]()
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    var locationModel = LocationModel()
    var firebaseModel = FirebaseModel()
    
    //var isAdmin: Bool = false
    
    //var userUid: String
    
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
    
    func loginUser(email: String, password: String, userData: UserData, closure: @escaping () -> ()){
        var isAdmin: Bool = false
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, err in
            
            guard err == nil else {
                print("No account with tis e-mail")
                //If we cant sign in user we show alert
                //Show allert to create account
                return
            }
            
            //Här vill vi komma till nästa vy
            //closure()
            print("Inloggning, sucsess, du är inloggad")
            
            if let result = result {
                //print("Kommer in i result if-satsen")
                let userUid = result.user.uid
                //db.collection(usersCollection).addSnapshotListener { (snapshot, err ) in
                
                
                //db.collection("users/type/\(userUid)")
                let docRef = self.db.collection("admin").document(userUid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        isAdmin = true
                        print("Is admin")
                        //print("Document data: \(dataDescription)")
                    } else {
                        //let docRefUser = db.collection("user").document(userUid)
                        print("Is user")
                        print("Document does not exist")
                    }
                    var finalDocRef: DocumentReference
                    print("isAdmin: \(isAdmin)")
                    if isAdmin {
                        finalDocRef = self.db.collection("admin").document(userUid)
                    } else {
                        finalDocRef = self.db.collection("user").document(userUid)
                    }
                    userData.userDocRef = finalDocRef
                    
                    closure()
                }
                /*
                var finalDocRef: DocumentReference
                print("isAdmin: \(isAdmin)")
                if isAdmin {
                    finalDocRef = self.db.collection("admin").document(userUid)
                } else {
                    finalDocRef = self.db.collection("user").document(userUid)
                }
                userData.userDocRef = finalDocRef
                
                closure()*/

                
                
                /*db.reference().child("admin/\(userUid)").observeSingleEvent(of: .value, with: { snapshot in
                    print("Letar i vår databas efter en viss användare")
                    
                    if let snapshotValue = snapshot.value as? String {
                        switch snapshotValue {
                        // If our user is admin...
                        case "admin":
                            print("User admin")
                            print("logged in som admin")
                        // ...redirect to the admin page
                        /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "adminVC")
                         self.present(vc!, animated: true, completion: nil)*/
                        // If out user is a regular user...
                        case "user":
                            print("User user")
                            print("Logged in som user")
                        // ...redirect to the user page
                        /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "userVC")
                         self.present(vc!, animated: true, completion: nil)*/
                        // If the type wasn't found...
                        default:
                            // ...print an error
                            print("Error: Couldn't find type for user \(userUid)")
                        }
                    }
                    
                })*/
            }
            
        })
        
        //var ref: DatabaseReference!
        // Sign in to Firebase
        //FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { (authDataResult: AuthDataResult?, error) in
            //(user, error) in
            // If there's no errors
            /*if error == nil {
                if let authDataResult = authDataResult {
                    self.userUid = authDataResult.user.uid
                    
                    // Get the type from the database. It's path is users/<userId>/type.
                    // Notice "observeSingleEvent", so we don't register for getting an update every time it changes.
                    Database.database().reference().child("users/\(userUid)/type").observeSingleEvent(of: .value, with: {
                        (snapshot) in
                        
                        switch snapshot.value as! String {
                        // If our user is admin...
                        case "admin":
                            print("User admin")
                            // ...redirect to the admin page
                            /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "adminVC")
                            self.present(vc!, animated: true, completion: nil)*/
                        // If out user is a regular user...
                        case "user":
                            print("User user")
                            // ...redirect to the user page
                            /*let vc = self.storyboard?.instantiateViewController(withIdentifier: "userVC")
                            self.present(vc!, animated: true, completion: nil)*/
                        // If the type wasn't found...
                        default:
                            // ...print an error
                            print("Error: Couldn't find type for user \(userUid)")
                        }
                    })
                    // authDataResult.user.email for the email address in firebase
                }
                
            }*/
        //})
        
    }
    
    func resetPassword(){
        
    }
    
    func createAccount(email: String, password: String, name: String, businessAccount: Bool, businessUserAssets: BusinessUser?){
        
        //let values = ["name": name, "email": email]
        //self.ref.child("users").child(user.uid).setValue(values)
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print("Error in creating account")
                print(error.localizedDescription )
            } else {
                //user registered successfully
                print("Registered sucsessfully")
                print(result)
                
                let userLocation = Location(name: "", latitude: 59.4269, longitude: 17.9520)
                
                let newUser = User(name: "\(name)",
                                email: "\(email)",
                                productType: "Naglar",
                                socialMedia: "@naglar.bylopez",
                                businessAccount: businessAccount,
                                userLocation: userLocation,
                                businessUser: businessUserAssets!
                )
                
                if let result = result {
                    let userUid = result.user.uid
                    
                    switch businessAccount {
                    case true:
                        self.firebaseModel.saveUserToFirestore(user: newUser, userType: "admin", userUid: userUid)
                        //self.saveUserToFirestore(user: newUser, userType: "admin", userUid: userUid)
                        //Database.database().reference().child("users/\(userUid)/admin")
                    case false:
                        //Database.database().reference().child("users/\(userUid)/user")
                        self.firebaseModel.saveUserToFirestore(user: newUser, userType: "user", userUid: userUid)
                    
                    }
                }
                
                /*
                let userLocation = Location(name: "", latitude: 59.4269, longitude: 17.9520)
                
                let newUser = User(name: "\(name)",
                                email: "\(email)",
                                productType: "Naglar",
                                socialMedia: "@naglar.bylopez",
                                businessAccount: businessAccount,
                                userLocation: userLocation)*/
                
               // self.saveUserToFirestore(user: newUser)
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
    
    func saveUserToFirestore(user: User, userType: String, userUid: String){
        do {
            _ = try db.collection("\(userType)/\(userUid)").addDocument(from: user)
        } catch {
            print("Error in saving to DB")
        }
    }
}
