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
    @State private var redirectBannerVideoPlayer = false
    @State private var redirectWatchLater = false
    @State private var redirectWatchLaterVideoPlayer = false
    
    // assigned properties to json
    @State private var seriesDetailID: String = ""
    @State private var seriesEpisodeDetailId: String = ""
    @State private var episodeCategoryID: String = ""
    @State private var selectedBannerUid: FeedBannerResults? = nil
    @State var watchlistEpisodeId =  ""
    
    // services model properties
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @StateObject var viewModel = ProfileViewModel(_dataService: GetServerData.shared)
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    //                if feedViewModel.showLoader {
                    //                    FLLoader()
                    //                } else {
                    FeedHeaderView(redirectSearch: $redirectSearch, redirectNotifications: $redirectNotifications)
                    ScrollView(showsIndicators: false) {
//                        CarousalView(redirectVideoPlayer: $redirectVideoPlayer)
//                            .environmentObject(feedViewModel)
                        let itemHeight: CGFloat = horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.33 : UIScreen.main.bounds.height * 0.23
                        let views = feedViewModel.feedBannerModel?.results.map { item -> AnyView in
                            AnyView(
                                LazyVStack {
                                    KFImage(URL(string: item.cover_art ?? ""))
                                        .placeholder {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.theme.appCardsColor)
                                                .frame(width: 358, height: itemHeight)
                                        }
                                        .loadDiskFileSynchronously()
                                        .cacheMemoryOnly()
                                        .fade(duration: 0.85)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: itemHeight)
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.theme.appGrayColor, lineWidth: 0.3)
                                        }
                                        .onTapGesture(perform: {
                                            selectedBannerUid = item
                                            print("selected banner id ----> " ,selectedBannerUid)
                                            redirectBannerVideoPlayer = true
                                            
                                        })
                                    
                                    NavigationLink(isActive: $redirectBannerVideoPlayer) {
                                        VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: item)
                                            .environmentObject(feedViewModel)
                                            .navigationBarBackButtonHidden(true)
                                    } label: {
                                        
                                    }
                                }
                            )
                        } ?? []

                        if views.isEmpty {
                            
                        } else {
                            
                            CarousalView(itemHeight: itemHeight, views: views)
                        }
                        
                        VStack(spacing: 20) {
                            ForEach(feedViewModel.feedCategoriesModel?.results ?? [], id: \.uid) { data in
                                if data.order == 1 {
                                    VStack(alignment: .leading, spacing: 10) {
                                        FeedSwiperHeaderView(title: data.title) {
                                            redirectSpecialSeriesDetail = true
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: nil, width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                        seriesDetailID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectSpecialSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectEpisodeDetail) {
                                                        EpisodeDetailView(seriesDetailID: $seriesDetailID).navigationBarBackButtonHidden(true)
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
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: result.title, width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: nil) {
                                                        redirectVideoPlayer = true
                                                        episodeCategoryID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectVideoPlayer) {
                                                        VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: episodeCategoryID, seriesUid: result)
                                                            .environmentObject(feedViewModel)
                                                            .navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectContinueWatchingDetail) {
                                                        ContinueWatchingDetailView(title: data.title, episodeID: result.categoryUUID ?? "")
                                                            .navigationBarBackButtonHidden(true)
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
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                        seriesDetailID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectEpisodeDetail) {
                                                        EpisodeDetailView(seriesDetailID: $seriesDetailID).navigationBarBackButtonHidden(true)
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
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                        seriesDetailID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectBonusContentSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectEpisodeDetail) {
                                                        EpisodeDetailView(seriesDetailID: $seriesDetailID).navigationBarBackButtonHidden(true)
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
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: nil, width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171, progressBarValue: nil) {
                                                        redirectEpisodeDetail = true
                                                        seriesDetailID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectPodcastSeriesDetail) {
                                                        ShowAllSeriesView(title: data.title, seriesID: result.categoryUUID ?? "").navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectEpisodeDetail) {
                                                        EpisodeDetailView(seriesDetailID: $seriesDetailID).navigationBarBackButtonHidden(true)
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
                                            LazyHStack(spacing: 3) {
                                                ForEach(data.results, id: \.uid) { result in
                                                    FeedSwiperView(feedImage: result.thumbnail ?? "", description: result.title, width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: nil) {
                                                        redirectVideoPlayer = true
                                                        episodeCategoryID = result.uid
                                                    }
                                                    
                                                    NavigationLink(isActive: $redirectVideoPlayer) {
                                                        VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: episodeCategoryID, seriesUid: result)
                                                            .environmentObject(feedViewModel)
                                                            .navigationBarBackButtonHidden(true)
                                                    } label: {
                                                        EmptyView()
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
                            
                            VStack(alignment: .leading, spacing: 10) {
                                if !feedViewModel.showLoader {
                                    FeedSwiperHeaderView(title: "Watch Later") {
                                        redirectWatchLater = true
                                    }
                                }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        LazyHStack(spacing: 3) {
                                            ForEach(feedViewModel.watchLaterEpisodesModel?.results ?? [], id: \.uid) { result in
                                                FeedSwiperView(feedImage: result.thumbnail ?? "", description: result.title, width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: nil) {
                                                    redirectWatchLaterVideoPlayer = true
                                                    watchlistEpisodeId = result.uid
                                                }
                                                
                                                NavigationLink(isActive: $redirectWatchLaterVideoPlayer) {
                                                    VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: watchlistEpisodeId, watchlistSeriesId: result)
                                                        .environmentObject(viewModel)
                                                        .environmentObject(feedViewModel)
                                                        .navigationBarBackButtonHidden(true)
                                                } label: {
                                                    EmptyView()
                                                }
                                            }
                                        }
                                    }
//                                }
                            }
                        }
                        .padding()
                    }
                    //                }
                }
                .padding(.top, 30)
                .onAppear {
                    feedViewModel.getFeedBanners()
                    feedViewModel.getFeedCategories()
                    feedViewModel.getWatchLaterEpisodes(id: "")
                }
                NavigationLink(isActive: $redirectSearch) {
                    SearchView().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $redirectWatchLater) {
                    WatchlistSeriesView().navigationBarBackButtonHidden(true)
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
