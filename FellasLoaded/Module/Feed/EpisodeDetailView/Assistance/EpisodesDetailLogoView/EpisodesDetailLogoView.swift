//
//  EpisodesDetailLogoView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EpisodesDetailLogoView: View {
    @Binding var logo: String
    
    var body: some View {
        Image(logo)
            .resizable()
            .scaledToFit()
            .frame(width: 203, height: 125)
            .padding()
    }
}
