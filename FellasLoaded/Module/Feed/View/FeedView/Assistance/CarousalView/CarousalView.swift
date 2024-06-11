//
//  CarousalView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import ACarousel
import Kingfisher

struct CarousalView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var feedViewModel: FeedViewModel
    @Binding var redirectVideoPlayer: Bool
    let items: [Item] = roles.map { Item(image: Image($0)) }
        
        var body: some View {
            ACarousel(feedViewModel.feedBannerModel?.results ?? [],
                      spacing: 10,
                      headspace: 10,
                      sidesScaling: 0.9,
                      isWrap: true,
                      autoScroll: .active(8)) { item in
                KFImage.init(URL(string: item.cover_art))
                    .placeholder({ progress in
                        ProgressView()
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.50)
                    .resizable()
                    .scaledToFill()
                    .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
                    .cornerRadius(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0.3)
                    }
                    .onTapGesture {
                        redirectVideoPlayer = true
                    }
//                item.image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                    .cornerRadius(10)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.white, lineWidth: 0.3)
//                    }
//                    .onTapGesture {
//                        redirectVideoPlayer = true
//                    }
            }
            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
        }
}

//#Preview {
//    CarousalView(redirectVideoPlayer: .constant(false))
//}

struct Item: Identifiable {
    let id = UUID()
    let image: Image
}

let roles = ["series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image"]
