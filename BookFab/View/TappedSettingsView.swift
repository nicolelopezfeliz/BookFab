//
//  TappedSettingsView.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-03.
//

import Foundation
import SwiftUI

struct TappedSettingsView: View {
    var index: Int
    
    
    var body: some View {
        HStack {
            
            
        }.ignoresSafeArea()
        .onAppear{
            setDestination(index: index)
        }
    }
    
    func setDestination(index: Int) {
        switch index {
        case 0:
            UnderConstructionView()
        case 1:
            ProfileViewSheet()
        case 2:
            UnderConstructionView()
        case 3:
            UnderConstructionView()
        default:
            UnderConstructionView()
        }
    }
}


/*
struct TappedSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingsRow(image: Image(systemName: "person.circle"), rowText: "Konto")
    }
}*/


