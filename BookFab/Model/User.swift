//
//  User.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-07.
//

import Foundation
import CoreLocation

struct User {
    var name: String
    var email: String
    var location = Location(name: "", latitude: 0.0, longitude: 0.0)
    var businessAccount: Bool
}
