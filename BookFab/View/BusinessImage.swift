//
//  BusinessImage.swift
//  BookFab
//
//  Created by Nicole Lopez feliz on 2021-02-17.
//

import SwiftUI

struct BusinessImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Rectangle())
            .frame(height: 200)
            .ignoresSafeArea()
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        BusinessImage(image: Image("nailimage"))
    }
}
