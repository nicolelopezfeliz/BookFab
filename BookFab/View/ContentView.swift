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
    
    @State var textEditorWidth = UIScreen.main.bounds.width / 1.4
    @State var textEditorHeight = UIScreen.main.bounds.height / 20
    
    let mailDefaultPlaceholder = "e-mail@example.com"
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
                
                PartedTitleText(title: appNameText)
                
                Spacer()
                
                VStack {
                    
                    Text(loginText)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding(.bottom)
                        .foregroundColor(ColorManager.darkPink)
                    
                    TextField(mailDefaultPlaceholder, text: $emailText)
                        .font(.body)
                        .foregroundColor(ColorManager.darkGray)
                        .frame(width: textEditorWidth, height: textEditorHeight, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(ColorManager.lightPink, lineWidth: 2)
                        )
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .onTapGesture {
                            
                        }
                    
                    /*TextEditor(text: $emailText)
                        .font(.body)
                        .foregroundColor(ColorManager.darkGray)
                        .frame(width: textEditorWidth, height: textEditorHeight, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(ColorManager.lightPink, lineWidth: 2)
                        )
                        //.padding()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .onTapGesture {
                            
                        }*/
                    
                    
                    SecureField(enterPasswordText, text: $passwordText)
                        .font(.body)
                        .foregroundColor(ColorManager.darkGray)
                        .frame(width: textEditorWidth, height: textEditorHeight, alignment: .leading)
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
                            .foregroundColor(ColorManager.buttonText)
                            .padding()
                            .cornerRadius(5.0)
                        
                    })
                        .padding(.bottom)
                        .cornerRadius(6)
                    
                }
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                /*.background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2))*/
                
                Spacer()
                
                PartedTextBtn(
                    infoText: registerAccountText,
                    btnText: registerTextBtn,
                    function: { regAccountSheet = .registerAccountScreen })
                
                PartedTextBtn(
                    infoText: forgotPasswordText,
                    btnText: resetPasswordBtn,
                    function: { Login().resetPassword() })
                
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
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
