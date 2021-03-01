//
//  AccountSettings.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-19.
//

import Foundation

struct AccountSettings {
    let defaultContent: String
    var content: String = ""
    var entry: String? = nil
    
    
    mutating func clearText() {
        if (entry == nil) {
            content = ""
        }
    }
    
    mutating func setContent() {
        if let content = entry {
            self.content = content
        } else {
            content = defaultContent
        }
        
    }
}
