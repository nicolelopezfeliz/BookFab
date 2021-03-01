//
//  UserData.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-26.
//

import Foundation
import Firebase

class UserData: ObservableObject {
    @Published var userDocRef: DocumentReference? = nil
    @Published var currUserData: UserDataModel? = UserDataModel()
}
