//
//  FirebaseModel.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-18.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseModel: ObservableObject {
    @Published var listOfLocations: [User]? = [User]()
    @Published var listOfUserNames: [String]? = [String]()
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    var auth = Firebase.Auth.auth()
    
    
    func getCurrentUserInfo(userType: String) {
        let user = Auth.auth().currentUser
        
        if let currentUser = user {
            db.collection("\(userType)").addSnapshotListener { (snapshot, err ) in
                if let err = err {
                    print("Error in getting documents \(err)")
                } else {
                    let uid = user?.uid
                    let userEmail = user?.email
                    
                    print("")
                }
                
            }}
    }
    func readUserLocationFromFirestore(){
        print("Nu kommer vi in i funktionen")
        
        guard let currentUser = auth.currentUser else {print("Error in finding user"); return }
        print("UID: \(currentUser.uid)")
        
        db.collection("admin").addSnapshotListener() { (snapshot, err) in
            if let err = err {
                print("Error in getting documents \(err)")
            } else {
                self.listOfLocations?.removeAll()
                for document in snapshot!.documents {
                    
                    let result = Result {
                        //Här omvandlar vi från dictionary till en item
                        try document.data(as: User.self)
                    }
                    //Resultatet av omvandlingen bestämmer vad vi får ut
                    switch result {
                    case .success(let item):
                        //Om omvandlingen är en sucsess får vi itemet
                        //print("Omvandlingen va en sucsess")
                        //Kollar om itemet är nil
                        if let item = item{
                            
                            self.listOfLocations?.append(item)
                            self.listOfUserNames?.append(item.name)
                            
                            
                            print("ITEM NAME: \(item.name)")
                            print("ITEM item: \(item)")
                            print("Item: \(item)")
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        //är omvandlingen en faliure
                        print("Error decoding item: \(error)")
                    }
                }
            }
            
            if let listOfUser = self.listOfLocations {
                for user in listOfUser {
                    print("ANVÄNDARE: \(user)")
                }
            }
        }
    }
    
    func saveUserToFirestore(user: User, userType: String, userUid: String){
        do {
            _ = try db.collection("\(userType)").document("\(userUid)").setData(from: user) //.addDocument(from: user)
        } catch {
            print("Error in saving to DB")
        }
    }
    
    func addBusinessUserInfo(){
        
    }
}
