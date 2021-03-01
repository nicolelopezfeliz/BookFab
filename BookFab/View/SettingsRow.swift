//
//  SettingsRow.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-19.
//

import Foundation
import SwiftUI

struct SettingsRow: View {
    var image: Image
    var rowText: String
    
    
    var body: some View {
        HStack {
            image
                .resizable()
                .frame(width: 25, height: 25)
            
            Text("\(rowText)")
            
            Spacer()
            
        }.ignoresSafeArea()
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingsRow(image: Image(systemName: "person.circle"), rowText: "Konto")
    }
}
