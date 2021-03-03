//
//  ProfileViewSheet.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-18.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ProfileViewSheet: View {
    @State var eMailText: String? = nil
    @State var passwordConfirmed: String? = nil
    @State var nameText: String? = nil
    @State var businessAccount: Bool? = nil
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    
    
    private let defaultContent = "Ange din vad du är certifierad i..."
    @State private var myProcuctsDescription = "Ange en beskrivning på dina produkter"
    @State private var aboutMe = "Ange en kort beskrivning om dig"
    @State private var mySocialMedia = "ange länk till sociala medier"
    
    @State var userUidString: String = ""
    @EnvironmentObject var currentProfileUser: UserData
    @State private var content: String = ""
    @State var businessUserInfo: BusinessUser? = nil
    
    
    
    var body: some View {
      
            
            ScrollView {
                VStack {
                    BusinessImage(image: Image("nailimage"))
                        .ignoresSafeArea(edges: .top)
                        .padding(.bottom, 0)
                        .offset(y: -130)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        CardView()
                            .background(Color(.blue))
                    }
                    
                }.frame(width: UIScreen.main.bounds.width)
                
            }
            .foregroundColor(.gray)
            
        
    }
    /*
     func getCurrentUserInfo() {
     let user = Auth.auth().currentUser
     
     if let currentUser = user {
     db.collection(usersCollection).addSnapshotListener { (snapshot, err ) in
     if let err = err {
     print("Error in getting documents \(err)")
     } else {
     let uid = user?.uid
     userUidString = user!.uid
     let userEmail = user?.email
     
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
     if let item = item {
     //print("Item: \(item)")
     displayCurrentUser = item
     } else {
     print("Document does not exist")
     }
     case .failure(let error):
     //är omvandlingen en faliure
     print("Error decoding item: \(error)")
     }
     }
     
     
     print("user email \(userEmail)")
     }
     
     }}
     
     }*/
    /*
     func saveBusinessInfoToUser(userUid: String, businessInfo: BusinessUser){
     do {
     _ = try db.collection("users/admin/\(userUid)").addDocument(data: ["businessInfo" : "\(businessInfo)"]) //.addDocument(from: businessInfo)
     } catch {
     print("Error in saving to DB")
     }
     }*/
    
    private func clearText() {
        if (businessUserInfo == nil) {
            content = ""
        }
    }
    
    private func setContent() {
        if let content = businessUserInfo?.certifiedIn {
            self.content = content
        } else {
            content = defaultContent
        }
        
    }
}
/*
struct ProfileViewSheet_Previews: PreviewProvider {
    static var previews: some View {
        //@Static let emailText = ""
        
        let businessUser = BusinessUserData(
            aboutMe: "Älskar burgare",
            certifiedIn: "Naglar",
            productType: "Naglar, fransar och fillers",
            socialMedia: "@nailsbyhannah")
        
        let user = UserDataModel(
            id: "",
            businessAccount: true,
            businessUser: businessUser,
            email: "",
            name: "")
        
        ProfileViewSheet(currentProfileUser: user)
    }
}*/
