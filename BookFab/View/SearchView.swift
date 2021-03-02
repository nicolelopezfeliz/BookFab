//
//  SearchView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-02.
//
/*
import Foundation
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var ShowCancelBtn = false
    let listOfUserNames = ["Anna", "Nicole", "Jakline", "Daniella", "Tina", "Ivan", "Lopez"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search", text: $searchText, onEditingChanged: { isEditing in
                            ShowCancelBtn = true
                        }, onCommit: {
                            print("On commit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                }
                
                if ShowCancelBtn {
                    Button("Cancel") {
                        UIApplication.shared.endEditing(true)
                        searchText = ""
                        ShowCancelBtn = false
                    }.foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(ShowCancelBtn)
            
            List {
                // Filtered list of names
                ForEach(listOfUserNames.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) { searchText in
                    Text(searchText)
                }
            }
            .navigationBarTitle(Text("Search"))
            .resignKeyboardOnDragGesture()
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
                .environment(\.colorScheme, .light)
            
            SearchView()
                .environment(\.colorScheme, .dark)
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
}*/

import SwiftUI

struct SearchView: View {
    let listOfNames: [String]
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
                    ForEach(listOfNames.filter{$0.hasPrefix(searchText) || searchText == ""}, id:\.self) {
                        searchText in Text(searchText)
                    }
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    
}



struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let listOfNames = ["Nicole", "Sara", "Joakim", "Paul", "Brian", "Brielle", "Anna-lynn"]
        
        Group {
           SearchView(listOfNames: listOfNames)
              .environment(\.colorScheme, .light)

           SearchView(listOfNames: listOfNames)
              .environment(\.colorScheme, .dark)
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
