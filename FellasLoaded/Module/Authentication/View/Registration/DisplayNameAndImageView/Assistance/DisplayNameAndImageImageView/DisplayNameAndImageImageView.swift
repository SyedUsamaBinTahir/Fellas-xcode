//
//  DisplayNameAndImageImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageImageView: View {
    @Binding var name: String
    var body: some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 108, height: 108, alignment: .center)
    }
}
