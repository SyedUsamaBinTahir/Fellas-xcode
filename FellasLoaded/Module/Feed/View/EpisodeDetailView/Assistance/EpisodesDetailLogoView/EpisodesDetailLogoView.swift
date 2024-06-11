//
//  EpisodesDetailLogoView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI
import Kingfisher

struct EpisodesDetailLogoView: View {
    @Binding var logo: String
    
    var body: some View {
        KFImage.init(URL(string: logo))
            .placeholder({ _ in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.theme.appGrayColor)
            })
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.80)
            .resizable()
            .scaledToFit()
            .frame(width: 203, height: 125)
            .padding()
    }
}
