//
//  BusinessUser.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-17.
//

import Foundation

class BusinessUser {
    var user: User?
    var certifiedIn: String
    var aboutMe: String
    var productType: String
    var socialMedia: String
    
    init(certifiedIn: String, aboutMe: String, productType: String, socialMedia: String){
        self.certifiedIn = certifiedIn
        self.aboutMe = aboutMe
        self.productType = productType
        self.socialMedia = socialMedia
        
    }
}
