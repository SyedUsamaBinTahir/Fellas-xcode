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
    @State private var seriesDetailID: String = ""
    @State private var seriesEpisodeDetailId: String = ""
    @State private var episodeCategoryID: String = ""
    @State private var bannerId = ""
    let items: [Item] = roles.map { Item(image: Image($0)) }
    
    var body: some View {
        Group {
            if let results = feedViewModel.feedBannerModel?.results, !results.isEmpty {
                ACarousel(results,
                          spacing: 12,
                          headspace: 5,
                          sidesScaling: 0.95,
                          isWrap: true,
                          autoScroll: .active(12)) { item in
                    
                    NavigationLink {
                        VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: item)
                                                    .environmentObject(feedViewModel)
                                                    .navigationBarBackButtonHidden(true)
                    } label: {
                        KFImage(URL(string: item.cover_art ?? ""))
                            .placeholder({ progress in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.theme.appCardsColor)
                                    .frame(width:  358, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
                            })
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.50)
                            .resizable()
                            .scaledToFill()
                            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.appGrayColor, lineWidth: 0.3)
                            }
                    }

//                    NavigationLink(isActive: $redirectVideoPlayer) {
//                        VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: item)
//                            .environmentObject(feedViewModel)
//                            .navigationBarBackButtonHidden(true)
//                    } label: {
//                       
//                    }
                }
                          .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
            } else {
                // Placeholder or loading view
//                Text("Loading...")
//                    .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
            }
        }
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


//                        ScrollView(.horizontal, showsIndicators: false) {
//                            LazyHStack(spacing: 10) {
//                                ForEach(feedViewModel.feedBannerModel?.results ?? [], id: \.uid) { data in
//                                    KFImage.init(URL(string: data.cover_art))
//                                        .placeholder({ progress in
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .fill(Color.theme.appCardsColor)
//                                                .frame(width:  358, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                                        })
//                                        .loadDiskFileSynchronously()
//                                        .cacheMemoryOnly()
//                                        .fade(duration: 0.50)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                                        .cornerRadius(10)
//                                        .overlay {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color.white, lineWidth: 0.3)
//                                        }
//                                        .onTapGesture {
////                                            redirectVideoPlayer = true
//                                        }
//                                }
//                            }
//                            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                            .padding(.horizontal)
//                        }
