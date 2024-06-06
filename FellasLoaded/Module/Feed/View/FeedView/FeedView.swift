//
//  FeedView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // Navigate to views properties
    @State private var redirectContinueWatchingDetail = false
    @State private var redirectSeriesDetail = false
    @State private var redirectEpisodeDetail = false
    @State private var redirectSearch = false
    @State private var redirectNotifications = false
    @State private var redirectVideoPlayer = false
    
    // services model properties
    @StateObject var feedViewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            VStack {
                
                FeedHeaderView(redirectSearch: $redirectSearch, redirectNotifications: $redirectNotifications)
                ScrollView {
//                    CarousalView(redirectVideoPlayer: $redirectVideoPlayer)
//                        .environmentObject(feedViewModel)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(feedViewModel.feedBannerModel?.results ?? [], id: \.uid) { data in
                                KFImage.init(URL(string: data.cover_art))
                                    .placeholder({ progress in
                                        ProgressView()
                                    })
                                    .loadDiskFileSynchronously()
                                    .cacheMemoryOnly()
                                    .fade(duration: 0.25)
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
                            }
                        }
                        .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
                        .padding(.horizontal)
                    }
                    
                    VStack(spacing: 20) {
                        FeedSwiperView(title: "Specials", feedImage: "series-image", width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Recently added", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, action: {
                            redirectContinueWatchingDetail = true
                        }, imageAction: {
                            redirectVideoPlayer = true
                        })
                        FeedSwiperView(title: "Continue watching", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, action: {
                            redirectContinueWatchingDetail = true
                        }, imageAction: {
                            redirectVideoPlayer = true
                        })
                        FeedSwiperView(title: "Series", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Bonus Content", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Podcasts", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Most Popular", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, action: {
                            redirectContinueWatchingDetail = true
                        }, imageAction: {
                            redirectVideoPlayer = true
                        })
                    }
                    .padding()
                }
                
            }
            .padding(.top, 30)
            .onAppear {
                   feedViewModel.getFeedBanners()
            }
            
            .navigationDestination(isPresented: $redirectContinueWatchingDetail) {
                ContinueWatchingDetailView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectSeriesDetail) {
                ShowAllSeriesView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectEpisodeDetail) {
                EpisodeDetailView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectSearch) {
                SearchView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectVideoPlayer) {
                VideoPlayerView().navigationBarBackButtonHidden(true)
            }
            
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FeedView()
}
