//
//  UserLocationData.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-26.
//

import Foundation

struct UserLocationData: Codable {
    var id: String
    var latitude: Double
    var longitude: Double
    var name: String
    
    
    enum CodingKeys: String, CodingKey {
    case id
    case latitude
    case longitude
    case name
    }


}
