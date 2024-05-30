//
//  DisplayNameAndImageImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageImageView: View {
    @Binding var image: UIImage?
    @State var action: () -> Void
    
    var body: some View {
        Button (action: action) {
            if let selectedImage = image {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 108, height: 108, alignment: .center)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 108, height: 108, alignment: .center)
            }
        }
    }
}
