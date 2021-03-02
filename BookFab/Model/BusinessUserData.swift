//
//  BusinessUserData.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-26.
//

import Foundation

struct BusinessUserData: Codable {
    var aboutMe: String
    var certifiedIn: String
    var productType: String
    var socialMedia: String
    
    enum CodingKeys: String, CodingKey {
        case aboutMe
        case certifiedIn
        case productType
        case socialMedia
    }
    
    
    
}



