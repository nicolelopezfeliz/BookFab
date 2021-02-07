//
//  ContentView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-01-28.
//

//ctrl + i = indentation

import SwiftUI
import Firebase

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
            Login().checkIfUserLoggedIn()
            //logoutUser()
        }
        .sheet(isPresented: $registerAccoutSheetShow){
            RegisterAccountSheet(eMailText: "\(emailText)")
        }
    }    //ctrl + i = indentation
    

    /*func checkLoggedInUser(){
        if Firebase.Auth.auth().currentUser != nil {
            print("DU är inloggad sen tidigare")
        } else {
            print("Ingen användare är inloggad")
        }
    }*/
    
    /*func loginBtn(email: String, password: String){
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { result, err in

            guard err == nil else {
                //If we cant sign in user we show alert
                //Show allert to create account
                return
            }
            
            //Här vill vi komma till nästa vy
            print("Inloggning, sucsess, du är inloggad")
        })
    }*/
    
    /*func logoutUser(){
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("You sucsessfully logged out")
        } catch  {
            print("Error in logging out")
        }
    }*/
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*func readFromFirestore(){
    db.collection("tmp").getDocuments() { (snapshot, err) in
        if let err = err {
            print("Error in document: \(err)")
        } else {
            //Om error inte är likamed nil så loopar vi egenom alla våra document
            for document in snapshot!.documents {
                print("\(document.documentID) : \(document.data())")
            }
        }
    }
    
}*/

/*func saveToFirestore (){
    
    //db.collection("tmp").addDocument(data: ["name" : "David"])
    
    do {
     db.collection("tmp").addDocument(data: ["name" : "David"])
     } catch {
     print("Error in saving to DB")
     }
    
}*/

/*func createAccount(email: String, password: String){
    FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, err in
        
        //db.collection(usersCollection).addDocument(data: ["name" : "David"])
        
        guard err == nil else {
            //Show account creation error
            print("Error när du skapade kontot")
            return
        }
    })
    
    //Vill göra en alert - när man klickar på skapa konto så skapar man konto
    let alert = UIAlertController(
        title: "Skapa konto",
        message: "Kontot existerar inte, vill du skapa ett konto?",
        preferredStyle: .alert)
    alert.addAction(UIAlertAction(
                        title: "Skapa Konto?",
                        style: .default,
                        handler: { _ in
                            
                        }))
    alert.addAction(UIAlertAction(
                        title: "Avbryt",
                        style: .cancel,
                        handler: { _ in
                            
                        }))
    
}*/
