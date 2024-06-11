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
    @State private var redirectSpecialSeriesDetail = false
    @State private var redirectPodcastSeriesDetail = false
    @State private var redirectBonusContentSeriesDetail = false
    @State private var redirectEpisodeDetail = false
    @State private var redirectSearch = false
    @State private var redirectNotifications = false
    @State private var redirectVideoPlayer = false
    
    // services model properties
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    
                    FeedHeaderView(redirectSearch: $redirectSearch, redirectNotifications: $redirectNotifications)
                    ScrollView {
                        //                    CarousalView(redirectVideoPlayer: $redirectVideoPlayer)
                        //                        .environmentObject(feedViewModel)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(feedViewModel.feedBannerModel?.results ?? [], id: \.uid) { data in
                                    KFImage.init(URL(string: data.cover_art))
                                        .placeholder({ progress in
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.theme.appGrayColor)
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
                        
                        LazyVStack(spacing: 20) {
                            ForEach(feedViewModel.feedCategoriesModel?.results ?? [], id: \.uid) { data in
                                if data.order == 1 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectSpecialSeriesDetail = true
                                        }
                                        ScrollView(.horizontal) {
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: nil, width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectSpecialSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectEpisodeDetail) {
                                                        EpisodeDetailView(seriesDetailID: result.uid ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                if data.order == 2 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectContinueWatchingDetail = true
                                        }
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 10) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: result.title, width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: nil) {
                                                        redirectVideoPlayer = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectContinueWatchingDetail) {
                                                        ContinueWatchingDetailView(title: data.title ,episodeID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                //                                FeedSwiperView(title: "Continue watching", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, action: {
                                //                                    redirectContinueWatchingDetail = true
                                //                                }, imageAction: {
                                //                                    redirectVideoPlayer = true
                                //                                })
                                if data.order == 4 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectSeriesDetail = true
                                        }
                                        ScrollView(.horizontal) {
                                            LazyHStack(spacing: 10) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                if data.order == 5 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectBonusContentSeriesDetail = true
                                        }
                                        ScrollView(.horizontal) {
                                            LazyHStack(spacing: 10) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectBonusContentSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                if data.order == 8 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectPodcastSeriesDetail = true
                                        }
                                        ScrollView(.horizontal) {
                                            LazyHStack(spacing: 10) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectPodcastSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                if data.order == 9 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectContinueWatchingDetail = true
                                        }
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 10) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail, description: result.title, width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: nil) {
                                                        redirectVideoPlayer = true
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectContinueWatchingDetail) {
                                                        ContinueWatchingDetailView(title: data.title ,episodeID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .padding(.top, 30)
                .onAppear {
                    feedViewModel.showLoader = true
                    feedViewModel.getFeedBanners()
                    feedViewModel.getFeedCategories()
                }
                
//                .navigationDestination(isPresented: $redirectContinueWatchingDetail) {
//                    ContinueWatchingDetailView().navigationBarBackButtonHidden(true)
//                }
//                .navigationDestination(isPresented: $redirectSeriesDetail) {
//                    ShowAllSeriesView().navigationBarBackButtonHidden(true)
//                }
//                .navigationDestination(isPresented: $redirectEpisodeDetail) {
//                    EpisodeDetailView().navigationBarBackButtonHidden(true)
//                }
//                .navigationDestination(isPresented: $redirectSearch) {
//                    SearchView().navigationBarBackButtonHidden(true)
//                }
//                .navigationDestination(isPresented: $redirectVideoPlayer) {
//                    VideoPlayerView().navigationBarBackButtonHidden(true)
//                }
                
                
                
                
                
                
                
                NavigationLink(isActive: $redirectSearch) {
                    SearchView().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $redirectVideoPlayer) {
                    VideoPlayerView().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }

                
                if feedViewModel.showLoader {
                    FLLoader()
                }
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
