//
//  BFApp.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-05.
//
import UIKit
import Firebase
import SwiftUI

@main
struct BFApp: App {
        

    @ObservedObject var userData: UserData
    @ObservedObject var firebaseModel: FirebaseModel
        
        init() {
            FirebaseApp.configure()
            userData = UserData()
            firebaseModel = FirebaseModel()
            
            firebaseModel.readUserLocationFromFirestore()
        }
        
        var body: some Scene {
            WindowGroup {
                ContentView()
                    .background(Color("Background").ignoresSafeArea())
                    .environmentObject(userData)
                    .environmentObject(firebaseModel)
            }
        }
    
}
