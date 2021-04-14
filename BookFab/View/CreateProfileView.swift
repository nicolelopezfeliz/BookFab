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
    
    @State private var myProcuctsDescription = "Ange en beskrivning på dina produkter"
    @State private var aboutMe = "Ange en kort beskrivning om dig"
    @State private var mySocialMedia = "ange länk till sociala medier"
    
    @State var eMailText: String? = nil
    @State var passwordConfirmed: String? = nil
    @State var nameText: String? = nil
    @State var businessAccount: Bool? = nil
    @State var activeFullScreen: ActiveScreenCover?
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 59.4286,
                                       longitude: 17.9513),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @State var userUidString: String = ""
    @State var content: String = ""
    @State var businessUserInfo: BusinessUserData? = nil
    
    var usersCollection = "locationTest"
    var db = Firestore.firestore()
        
    let heightFourth = UIScreen.main.bounds.height/4
    private let defaultContent = "Ange din vad du är certifierad i..."
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
                    .foregroundColor(ColorManager.darkGray)
                    .padding(10)
                
                CreateProfileTitles(
                    title: myProductsTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $myProcuctsDescription)
                    .font(.system(size: 14))
                    .foregroundColor(ColorManager.darkGray)
                    .padding(10)
                
                CreateProfileTitles(
                    title: aboutMeTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $aboutMe)
                    .font(.system(size: 14))
                    .foregroundColor(ColorManager.darkGray)
                    .padding(10)
                
                CreateProfileTitles(
                    title: socialMediaTitle,
                    textImage: Image(systemName: "moon.stars"))
                TextEditor(text: $mySocialMedia)
                    .font(.system(size: 14))
                    .foregroundColor(ColorManager.darkGray)
                    .padding(10)
                
                
                Button(action: {
                    let businessInfo = BusinessUserData(
                        aboutMe: aboutMe,
                        certifiedIn: content,
                        productType: myProcuctsDescription,
                        socialMedia: mySocialMedia)
                    
                    if let email = eMailText, let passwordConfirmed = passwordConfirmed,
                       let nameText = nameText, let businessAccount = businessAccount {
                        Login().createAccount(
                            email: email,
                            password: passwordConfirmed,
                            name: nameText,
                            businessAccount: businessAccount,
                            businessUserAssets: businessInfo
                        )
                    }
                    
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
                AdminOrUserView(isAdminOrUser: .businessUser)
            //.environmentObject(userData).environmentObject(firebaseModel)
            }
        }
        .onAppear{
            setContent()
            firebaseModel.readUserLocationFromFirestore()
            //getCurrentUserInfo()
        }
    }
    
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
                
            }
            
        }
        .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
