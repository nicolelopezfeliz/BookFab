//
//  FirebaseModel.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-18.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct FirebaseModel {
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    
    func getCurrentUserInfo(userType: String, userUid: String) {
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
