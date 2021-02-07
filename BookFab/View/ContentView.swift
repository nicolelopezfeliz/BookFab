//
//  ContentView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-01-28.
//

import SwiftUI

struct ContentView: View {
    let registerAccountText = "Har du inget konto?"
    let registerTextBtn = "Registrera"
    let forgotPasswordText = "Glömt lösenord?"
    let resetPasswordBtn = "Återställ lösenord"
    
    @State var loginText = "Login"
    @State var emailText = "e-mail@example.com"
    @State var passwordText = "********"
    
    
    var body: some View {
        ZStack {
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
                    
                    TextEditor(text: $passwordText)
                        .font(.body)
                        .foregroundColor(.gray)
                        .frame(width: 200, height: 40, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(ColorManager.lightPink, lineWidth: 2)
                        )
                        .padding()
                    
                    HStack {
                        Text(registerAccountText)
                            .font(.system(size: 13))
                            .foregroundColor(ColorManager.darkPink)
                            .frame(width: 122, height: 40, alignment: .leading)
                        
                        Button(action: {registerBtn()}) {
                            Text(registerTextBtn)
                                .bold()
                                .foregroundColor(ColorManager.darkPink)
                            
                        }

                    }
                    
                    HStack {
                        Text(forgotPasswordText)
                            .font(.system(size: 13))
                            .foregroundColor(ColorManager.darkPink)
                            .frame(width: 135, height: 40, alignment: .trailing)
                        
                        Button(action: {resetPassword()}) {
                            Text(resetPasswordBtn)
                                .bold()
                                .foregroundColor(ColorManager.darkPink)
                        }
                    }
                    
                    Spacer()
    
                    
                }
            }
        }
    }
}
func resetPassword(){
    
}

func registerBtn(){
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
