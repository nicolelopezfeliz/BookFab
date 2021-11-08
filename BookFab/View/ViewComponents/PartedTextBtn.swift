//
//  PartedTextBtn.swift
//  PartedTextBtn
//
//  Created by Nicole Lopez feliz on 2021-11-06.
//

import SwiftUI

struct PartedTextBtn: View {
    
    @State var infoText: String
    @State var btnText: String
    @State var function: () -> Void
    
    @State var frameWidth = UIScreen.main.bounds.width / 1.4
    @State var frameHeight = UIScreen.main.bounds.height / 35
    //@State var regAccountSheet: RegAccountSheet?
    
    var body: some View {
        HStack {
            Text(infoText)
                .font(.system(size: 13))
                .foregroundColor(ColorManager.darkPink)
                //.frame(width: 119, height: 40)
            
            Button(action: {
                //activeFullScreen = .registerAccountScreen
                //print("next view")
                //regAccountSheet = .registerAccountScreen
                function()
                
            }, label: {
                Text(btnText)
                    .bold()
                    .foregroundColor(ColorManager.darkPink)
                
            })
        }.frame(width: frameWidth, height: frameHeight, alignment: .leading)
    }
}
