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

struct ContentView: View {
    
    let registerAccountText = "Har du inget konto?"
    let registerTextBtn = "Registrera"
    let forgotPasswordText = "Glömt lösenord?"
    let resetPasswordBtn = "Återställ lösenord"
    
    @State var loginText = "Login"
    @State var emailText = "e-mail@example.com"
    @State var passwordText = ""
    //@State var showAlert = true
    @State var registerAccoutSheetShow = false
    @State var mapScreenPresentet = false
    
    //@State var eMailEntry: String? = nil
    
        
    var body: some View {
        
        
        NavigationView {
            VStack {
                Text(loginText)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(width: 300, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding()
                    .foregroundColor(ColorManager.darkPink)
                
                TextEditor(text: $emailText)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Enter password", text: $passwordText)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 40, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(ColorManager.lightPink, lineWidth: 2)
                    )
                    .padding()
                
                Button(action: {
                    Login().loginUser(email: emailText, password: passwordText)
                    mapScreenPresentet = Login().checkIfUserLoggedIn()
                }, label: {
                    Text(loginText)
                        .font(.title3)
                        .frame(width: 160,
                               height: 40,
                               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(ColorManager.darkPink)
                        .foregroundColor(.white)
                        .padding()
                        .cornerRadius(5.0)
                })/*.alert(isPresented: $showAlert, content: { () -> alert in
                 alert = UIAlertController(
                 title: "Skapa konto",
                 message: "Kontot existerar inte, vill du skapa ett konto?",
                 preferredStyle: .alert)
                 })*/
                //
                HStack {
                    Text(registerAccountText)
                        .font(.system(size: 13))
                        .foregroundColor(ColorManager.darkPink)
                        .frame(width: 119, height: 40, alignment: .leading)
                    
                    Button(action: {
                        print("CLICKED")
                        registerAccoutSheetShow = true
                            
                        
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
                
                
                
            }
            
        }.onAppear() {
            mapScreenPresentet = Login().checkIfUserLoggedIn()
            Login().logOutUser()
        }
        .sheet(isPresented: $registerAccoutSheetShow){
            RegisterAccountSheet(eMailText: "\(emailText)")
        }
        .fullScreenCover(isPresented: $mapScreenPresentet, content: {
            MapView.init(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
        })
        
    }    //ctrl + i = indentation
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
