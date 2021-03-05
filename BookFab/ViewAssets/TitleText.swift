//
//  TitleText.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-03-05.
//

import Foundation
import SwiftUI

struct TitleText: View {
    
    var title: String
    var textImage: Image
    @State var textContent: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(ColorManager.darkPink)
                
            }
            
            HStack {
                
                textImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                
                Text(textContent)
                    .font(.system(size: 14))
                    .foregroundColor(ColorManager.darkGray)
                    .padding(10)
                
            }
            
        }
        .padding(.init(top: 15, leading: 10, bottom: 15, trailing: 10))
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}
