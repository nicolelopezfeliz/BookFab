//
//  PartedTitleText.swift
//  PartedTitleText
//
//  Created by Nicole Lopez feliz on 2021-11-06.
//

import SwiftUI

struct PartedTitleText: View {
    
    @State var title: String
    @State var firstText: String?
    @State var lastText: String?
    
    let offsetX = UIScreen.main.bounds.width * -0.02
    let offsetY = UIScreen.main.bounds.width * 0.02
    
    let errorText = "error"
    
    var body: some View {
        HStack {
            Text(firstText ?? errorText)
                .font(.largeTitle.weight(.bold))
                .foregroundColor(ColorManager.darkPink)
            
            
            //    Text("Vad händer yao")
            Text(lastText ?? errorText)
                .font(.largeTitle.italic())
                .foregroundColor(ColorManager.darkPink)
                .offset(x: offsetX, y: offsetY)
                //.offset(x: -10, y: 10)
                
            
            
        }
        .onAppear {
            setText(text: title)
        }
    }
    
    func setText(text: String) {
        if let a = text.components(separatedBy: " ").first, let b = text.components(separatedBy: " ").last {
            self.firstText = a
            self.lastText = b
        }
    }
}

struct PartedTitleText_Previews: PreviewProvider {
    static var previews: some View {
        PartedTitleText(title: "Book Fab")
    }
}
