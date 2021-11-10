//
//  ClearButton.swift
//  ClearButton
//
//  Created by Nicole Lopez feliz on 2021-11-10.
//

import Foundation
import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    
    let emptyValue = ""
    let imageName = "x.circle"
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button(action: {
                    self.text = emptyValue
                }){
                    Image(systemName: imageName)
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 8)
            }
        }
    }
}
