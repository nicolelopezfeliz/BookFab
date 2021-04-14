//
//  ContentView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-01-28.
//

//ctrl + i = indentation

import SwiftUI
import Firebase
import MapKit
import FirebaseFirestoreSwift

enum ActiveScreenCoverC: Identifiable {
     case registerAccountScreen, adminView, userView

     var id: Int {
         hashValue
     }
 }

enum RegAccountSheet: Identifiable {
     case registerAccountScreen

     var id: Int {
         hashValue
     }
 }

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var loginText = "Login"
    @State var emailText = "admin09@example.com"
    @State var passwordText = "123456"
    @State var activeFullScreen: ActiveScreenCoverC?
    @State var regAccountSheet: RegAccountSheet?
    
    let registerAccountText = "Har du inget konto?"
    let registerTextBtn = "Registrera"
    let forgotPasswordText = "Glömt lösenord?"
    let resetPasswordBtn = "Återställ lösenord"
    let appNameText = "Book Fab"
    let enterPasswordText = "Enter password"
  
    init(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("User is now logged in \(user.uid)")
            } else {
                print("No user signed in")
            }
        }
    }
    
        
    var body: some View {
        
        
        NavigationView {
            VStack {
                Text(appNameText)
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(ColorManager.darkPink)
                
                Text(loginText)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                    .foregroundColor(ColorManager.darkPink)
                
                TextEditor(text: $emailText)
                    .font(.body)
                    .foregroundColor(ColorManager.darkGray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .onTapGesture {
                        
                    }
                    
                
                SecureField(enterPasswordText, text: $passwordText)
                    .font(.body)
                    .foregroundColor(ColorManager.darkGray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                Button(action: {
                    Login().loginUser(email: emailText, password: passwordText, userData: userData) {
                        activeFullScreen = .userView
                    }
                    adminFullScreenClosure: {
                        activeFullScreen = .adminView
                        
                    }
                    
                }, label: {
                    Text(loginText)
                        .font(.title)
                        .frame(width: 160,
                               height: 40,
                               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(ColorManager.darkPink)
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(5.0)
                    
                })
                
                /*.alert(isPresented: $showAlert, content: { () -> alert in
                    alert = UIAlertController(
                        title: "Skapa konto",
                        message: "Kontot existerar inte, vill du skapa ett konto?",
                        preferredStyle: .alert)
                })*/
                
                HStack {
                    Text(registerAccountText)
                        .font(.system(size: 13))
                        .foregroundColor(ColorManager.darkPink)
                        .frame(width: 119, height: 40, alignment: .leading)
                    
                    Button(action: {
                        //activeFullScreen = .registerAccountScreen
                        regAccountSheet = .registerAccountScreen
                        
                            
                        
                    }, label: {
                        Text(registerTextBtn)
                            .bold()
                            .foregroundColor(ColorManager.darkPink)
                        
                    })
                    
                }
                
                HStack {
                    Text(forgotPasswordText)
                        .font(.system(size: 13))
                        .foregroundColor(ColorManager.darkPink)
                        .frame(width: 130, height: 40, alignment: .trailing)
                    
                    Button(action: {
                        Login().resetPassword()
                        
                    }, label: {
                        Text(resetPasswordBtn)
                            .bold()
                            .foregroundColor(ColorManager.darkPink)
                    })
                }
                
                Spacer()
                
                
                
            }.fullScreenCover(item: $activeFullScreen) { item in
                switch item {
                case .registerAccountScreen:
                    RegisterAccountSheet(eMailText: "\(emailText)")
                case .adminView:
                    if let currentUser = userData.currUserData {
                        //AdminUserView()
                        AdminOrUserView(isAdminOrUser: .businessUser)
                    }
                case .userView:
                    //UserView()
                    AdminOrUserView(isAdminOrUser: .customerUser)
                }
            }
        }
        .sheet(item: $regAccountSheet) { item in
            switch item {
            case .registerAccountScreen:
                RegisterAccountSheet(eMailText: "\(emailText)")
            }
            
        }
        .onAppear() {
            Login().logOutUser()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
