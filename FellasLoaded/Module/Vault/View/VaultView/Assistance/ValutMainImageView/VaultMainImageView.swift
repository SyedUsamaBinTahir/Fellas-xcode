//
//  VaultMainImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultMainImageView: View {
    @Binding var images: String
    
    var body: some View {
        Image(images)
            .resizable()
            .scaledToFit()
    }
}
