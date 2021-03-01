//
//  TextManager.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-24.
//

import Foundation

class TextManager {
    var content: String = ""
    var entry: String? = nil
    
    
    func clearText(entry: String) {
        if (entry == nil) {
            content = ""
        }
    }
    
    func setContent(defaultContent: String) {
        if let content = entry {
            self.content = content
        } else {
            content = defaultContent
        }
        
    }
}
