//
//  FeedView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct FeedView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var redirectContinueWatchingDetail = false
    @State private var redirectSeriesDetail = false
    @State private var redirectEpisodeDetail = false
    @State private var redirectSearch = false
    @State private var redirectVideoPlayer = false
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .center) {
                    Button {
                        redirectSearch = true
                    } label: {
                        Image("search-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                    Image("fellas-loaded-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 98, height: 42, alignment: .center)
                        .clipped()
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("notifications")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                .padding()
                ScrollView {
                    CarousalView()
                    
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
                        FeedSwiperView(title: "Series", feedImage: "series-image", width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Bonus Content", feedImage: "series-image", width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, action:  {
                            redirectSeriesDetail = true
                        }, imageAction: {
                            redirectEpisodeDetail = true
                        })
                        FeedSwiperView(title: "Podcasts", feedImage: "series-image", width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, action:  {
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
