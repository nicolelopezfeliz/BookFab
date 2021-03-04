//
//  CreateProfileView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-03.
//

import Foundation
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
import MapKit

enum ActiveScreenCover: Identifiable {
    case adminUserView
    
    var id: Int {
        hashValue
    }
}

struct CreateProfileView: View {
    @EnvironmentObject var firebaseModel: FirebaseModel
    
    @EnvironmentObject var userData: UserData
    
    @State var eMailText: String? = nil
    @State var passwordConfirmed: String? = nil
    @State var nameText: String? = nil
    @State var businessAccount: Bool? = nil
    
    @State var activeFullScreen: ActiveScreenCover?
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.4285,
                                       longitude: 17.9512),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
    
    
    private let defaultContent = "Ange din vad du är certifierad i..."
    @State private var myProcuctsDescription = "Ange en beskrivning på dina produkter"
    @State private var aboutMe = "Ange en kort beskrivning om dig"
    @State private var mySocialMedia = "ange länk till sociala medier"
    
    @State var userUidString: String = ""
    @State var displayCurrentUser: User? = nil
    @State var content: String = ""
    @State var businessUserInfo: BusinessUser? = nil
    
    let heightFourth = UIScreen.main.bounds.height/4
    private let certefiedTitle = "Certifierad"
    private let myProductsTitle = "Mina Produkter"
    private let aboutMeTitle = "Lite om mig"
    private let socialMediaTitle = "Instagram"
    private let editProfileText = "Vill du editera din profil? Gå till din profil under \"Inställningar\""
    private let image = Image(systemName: "heart.text.square")
    
    var body: some View {
        VStack(alignment: .leading){
            
            ScrollView {
                Image("nailimage")
                    .resizable()
                    .frame(height: heightFourth)
                    .ignoresSafeArea(edges: .top)
                
                CreateProfileTitles(
                    title: certefiedTitle,
                    textImage: Image(systemName: "moon.stars"))
                
                TextEditor(text: $content)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(10)
                
                CreateProfileTitles(
                    title: myProductsTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $myProcuctsDescription)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(10)
                
                CreateProfileTitles(
                    title: aboutMeTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $aboutMe)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(10)
                
                CreateProfileTitles(
                    title: socialMediaTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $mySocialMedia)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(10)
                
                
                Button(action: {
                    let businessInfo = BusinessUser(
                        certifiedIn: content,
                        aboutMe: aboutMe,
                        productType: myProcuctsDescription,
                        socialMedia: mySocialMedia)
                    
                    Login().createAccount(
                        email: eMailText!,
                        password: passwordConfirmed!,
                        name: nameText!,
                        businessAccount: businessAccount!,
                        businessUserAssets: businessInfo
                    )
                    
                    //saveBusinessInfoToUser(userUid: userUidString, businessInfo: businessInfo)
                    activeFullScreen = .adminUserView
                    
                    print("User UID: \(userUidString)")
                    
                }, label: {
                    Text("Continue")
                        .bold()
                        .foregroundColor(.blue)
                    
                })
                
                
                
            }.frame(height: heightFourth * 3)
        }.fullScreenCover(item: $activeFullScreen) { item in
            switch item {
            case .adminUserView:
                AdminUserView(
                    mapView: MapNav(
                        region: region,
                        listOfLocations: firebaseModel.listOfLocations!),
                    currentUser: userData.currUserData!).environmentObject(userData).environmentObject(firebaseModel)
            }
        }
        .onAppear{
            setContent()
            firebaseModel.readUserLocationFromFirestore()
            //getCurrentUserInfo()
        }
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

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        //@Static let emailText = ""
        
        CreateProfileView()
    }
}

struct CreateProfileTitles: View {
    var title: String
    var textImage: Image
    //@State var textContent: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(ColorManager.darkPink)
                
            }
            
            HStack {
                
                textImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                
                /*TextEditor(text: $textContent)
                    .font(.system(size: 14))
                    .foregroundColor(.black)
                    .padding(10)*/
                
            }
            
        }
        .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
