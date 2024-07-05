//
//  EpisodesDetailImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI
import Kingfisher

struct EpisodesDetailImageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var image: String
    
    var body: some View {
        KFImage.init(URL(string: image))
            .placeholder({ _ in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.theme.appCardsColor)
            })
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.50)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.40 : 488)
            .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 10, style: .continuous))
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.white.opacity(0.1)]), startPoint: .bottom, endPoint: .center)
    }
}
