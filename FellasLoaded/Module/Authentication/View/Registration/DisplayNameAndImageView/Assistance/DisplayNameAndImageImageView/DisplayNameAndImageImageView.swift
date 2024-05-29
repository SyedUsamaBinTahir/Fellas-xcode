//
//  DisplayNameAndImageImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageImageView: View {
    @Binding var image: Image?
    @State var action: () -> Void
    
    var body: some View {
        Button (action: action) {
            image?
                .resizable()
                .scaledToFit()
                .frame(width: 108, height: 108, alignment: .center)
        }  
    }
}
