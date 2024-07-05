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
                    .cornerRadius(60)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay {
                        Circle()
                            .stroke(Color.white)
                    }
            } else {
                Image("default-profile-icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 108, height: 108, alignment: .center)
                    .cornerRadius(60)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay {
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .overlay(alignment: .bottomTrailing) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 10)
                                    .padding(7)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(60)
                                    .padding(.trailing, 10)
                            }
                    }
            }
        }
    }
}
