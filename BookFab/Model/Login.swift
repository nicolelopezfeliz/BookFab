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
    @EnvironmentObject var firebaseModel: FirebaseModel
    @EnvironmentObject var userData: UserData
    
    @State private var isUserAdmin = false
    @State var alertIsPresented = true

    private var listOfLocations = [Location]()
    
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
    
    func loginUser(email: String, password: String, userData: UserData, userFullScreenClosure: @escaping () -> (), adminFullScreenClosure: @escaping () -> ()){
        var isAdmin: Bool = false
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, err in
            
            guard err == nil else {
                //self.handleError(err!, alertClosure: alertClosure)      // use the handleError method
                //If we cant sign in user we show alert
                //Show allert to create account
                return
            }
            
            //Här vill vi komma till nästa vy
            //closure()
            
            if let result = result {
                let userUid = result.user.uid
                //db.collection(usersCollection).addSnapshotListener { (snapshot, err ) in
                
                //db.collection("users/type/\(userUid)")
                let docRef = self.db.collection("admin").document(userUid)
                
                docRef.getDocument { (document, error) in
                    print("TAG documment ", document)
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        isAdmin = true
                        userData.isUserAdmin = true
                    } else {
                        //let docRefUser = db.collection("user").document(userUid)
                    }
                    var finalDocRef: DocumentReference
                    if isAdmin {
                        finalDocRef = self.db.collection("admin").document(userUid)
                    } else {
                        finalDocRef = self.db.collection("user").document(userUid)
                    }
                    userData.userDocRef = finalDocRef
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if isAdmin {
                            adminFullScreenClosure()
                        } else {
                            userFullScreenClosure()
                        }
                        
                        
                        
                    //closure()
                    }
                }
            }
        })
    }
   /*
    private func deterAdminOrUser(fullScreenClosure: @escaping () -> ()){
        if userData.isUserAdmin == true {
            //Skicka med i closure vilken vy som ska visas
            //activeFullScreen = .adminView
            //currentUser = userData.currUserData
            fullScreenClosure()
            
        } else {
            //Skicka med i closure vilken vy som ska visas
            //activeFullScreen = .userView
            fullScreenClosure()
            //firebaseModel.getCurrentUserInfo(userType: "user")
        }
    }*/
    
    func resetPassword(){
        
    }
    
    func createAccount(email: String, password: String, name: String, businessAccount: Bool, businessUserAssets: BusinessUserData?){
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print("Error in creating account")
                print(error.localizedDescription )
            } else {
                //user registered successfully
                print("Registered sucsessfully")
                //print(result)
                
                let userLocation = Location(name: "", latitude: 59.4263, longitude: 17.9120)
                
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
            }
            
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

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}

extension Login {
    func handleError(_ error: Error, alertClosure: @escaping () -> ()) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)

            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)

            alert.addAction(okAction)
            
            //self.present(alert, animated: true, completion: nil)

        }
    }
}
