//
//  SearchView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-02.
//
import SwiftUI

struct SearchView: View {
    @EnvironmentObject var firebaseModel: FirebaseModel

    @State var pressedUserName = ""
    @State private var searchText = ""
    @State private var showCancelBtn: Bool = false

    var body: some View {

        
            VStack {
                // Search view
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")

                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelBtn = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(.primary)

                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)

                    if showCancelBtn  {
                        Button("Cancel") {
                                UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                                self.searchText = ""
                                self.showCancelBtn = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelBtn) // .animation(.default) // animation does not work properly

                List {
                    // Filtered list of names
                    //SettingsRow(image: Image(systemName: "\(listOfSettings[num])"), rowText: "\(listOfSettingTitle[num])")
                    if let listOfLocations = firebaseModel.listOfLocations {
                        ForEach(listOfLocations.indices, id:\.self) { index in
                            NavigationLink(
                                destination: DisplayBusinessSheet(user: listOfLocations[index]),
                                label: {
                                    Text(listOfLocations[index].name)
                                })
                                .foregroundColor(ColorManager.darkGray)
                        }
                    }
                    
                    
                    /*ForEach(listOfNames.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in
                        
                        NavigationLink(
                            destination: DisplayBusinessSheet(user: <#T##User#>),
                            label: {
                                Text(searchText)
                            })
                        
                    }*/
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
