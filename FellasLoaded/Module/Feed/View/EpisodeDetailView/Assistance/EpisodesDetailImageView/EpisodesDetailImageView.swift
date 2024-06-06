//
//  EpisodesDetailImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EpisodesDetailImageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.40 : 488)
    }
}
