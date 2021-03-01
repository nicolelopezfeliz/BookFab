//
//  UserDataModel.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-26.
//

import Foundation

struct UserDataModel: Codable, Identifiable {
    var id = UUID()
    
    var businessAccount: Bool?
    var businessUser: [BusinessUserData]? = []
    var email: String?
    var name: String?
    var userLocation: [UserLocationData]? = []
    
    enum CodingKeys: String, CodingKey {
    case businessAccount
    case businessUser
    case email
    case name
    case userLocation
    }

}
