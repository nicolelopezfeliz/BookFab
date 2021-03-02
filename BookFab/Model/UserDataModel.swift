//
//  UserDataModel.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-26.
//

import Foundation
import FirebaseFirestoreSwift

struct UserDataModel: Codable, Identifiable {
    @DocumentID var id: String?
    
    var businessAccount: Bool?
    var businessUser: BusinessUserData?
    var email: String?
    var name: String?
    var userLocation: UserLocationData? 
    
    enum CodingKeys: String, CodingKey {
        case id
        case businessAccount
        case businessUser
        case email
        case name
        case userLocation
    }
    
}
