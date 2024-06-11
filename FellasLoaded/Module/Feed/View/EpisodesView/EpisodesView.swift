//
//  EpisodesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import Kingfisher

struct EpisodesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var seriesImage: String = ""
    var episode: String = ""
    var title: String = ""
    var description: String = ""
    var icon: String = ""
    
    var body: some View {
        HStack(spacing: 16) {
//            Image("\(seriesImage)")
//                .resizable()
//                .scaledToFill()
//                .frame(width: horizontalSizeClass == .regular ? 345 : 124, height: horizontalSizeClass == .regular ? 194 : 69)
//                .clipped()
//                .cornerRadius(10)
            KFImage.init(URL(string: "\(FLAPIs.imageURL + seriesImage)"))
                .placeholder({ _ in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.theme.appGrayColor)
                })
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.80)
                .resizable()
                .scaledToFill()
                .frame(width: horizontalSizeClass == .regular ? 345 : 124, height: horizontalSizeClass == .regular ? 194 : 69)
                .clipped()
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(episode)
                    .font(.custom(Font.Medium, size: 14))
                    .foregroundStyle(Color.theme.textGrayColor)
                Text(title)
                    .font(.custom(Font.Medium, size: horizontalSizeClass == .regular ? 24 : 16))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                
                if horizontalSizeClass == .regular {
                    Text(description)
                        .font(.custom(Font.regular, size: 18))
                        .foregroundStyle(Color.theme.textGrayColor)
                        .lineLimit(2)
                }
            }
            Spacer()
            Image("\(icon)")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 23)
        }
    }
}

#Preview {
    EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why", icon: "download")
}
