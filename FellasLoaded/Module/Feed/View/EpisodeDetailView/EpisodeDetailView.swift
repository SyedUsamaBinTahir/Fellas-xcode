//
//  EpisodeDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI

struct EpisodeDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var feedCategorySeriesDetailModel: FeedCategorySeriesDetailModel?
    @State private var redirectVideoPlayer = false
    @State private var redirectVideoPlayerWithEpisode = false
    @State var seriesEpisodeDetailId: String = ""
    @Binding var seriesDetailID: String
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView(showsIndicators: false) {
                    ZStack(alignment: horizontalSizeClass == .regular ? .topLeading : .center) {
                        if horizontalSizeClass == .regular {
                            EpisodesDetailImageView(image: .constant(feedViewModel.feedCategorySeriesDetailModel?.horizontal_cover_photo ?? ""))
                        } else {
                            EpisodesDetailImageView(image: .constant(feedViewModel.feedCategorySeriesDetailModel?.vertical_cover_photo ?? ""))
                        }
                        
                        VStack(alignment: horizontalSizeClass == .regular ? .leading : .center) {
                            EpisodesDetaulBackButtonView()
                            
                            if horizontalSizeClass != .regular {
                                Spacer()
                                
                                
                                EpisodesDetailLogoView(logo: .constant(feedViewModel.feedCategorySeriesDetailModel?.logo ?? ""))
                            }
                            
                            if horizontalSizeClass == .regular {
                                VStack(alignment: .leading, spacing: 16) {
                                    EpisodesDetailLogoView(logo: .constant(feedViewModel.feedCategorySeriesDetailModel?.logo ?? ""))
                                    
                                    PlayButtonView { redirectVideoPlayer = true }
                                    
                                    EpisodesDetailDescriptionView(seasonNumber: .constant("S\(feedViewModel.feedCategorySeriesDetailModel?.sessions_count ?? 0): E\(feedViewModel.feedCategorySeriesDetailModel?.episodes_count ?? 0)"), desctiption: .constant(feedViewModel.feedCategorySeriesDetailModel?.description ?? ""))
                                        .environmentObject(feedViewModel)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.60)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .frame(height: 488)
//                    .padding(.top, 50)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        if horizontalSizeClass != .regular {
                            Button {
                                redirectVideoPlayerWithEpisode = true
                                
                            } label: {
                                HStack {
                                    Image("play-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    Text("PLAY")
                                        .font(.custom(Font.bold, size: 16))
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 48)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                            }
                            
                            WatchlistAndShareButtonView(watchlistAction: {}, shareAction: {})
                            
                            EpisodesDetailDescriptionView(seasonNumber: .constant("S\(feedViewModel.feedCategorySeriesDetailModel?.sessions_count ?? 0): E\(feedViewModel.feedCategorySeriesDetailModel?.episodes_count ?? 0)"), desctiption: .constant(feedViewModel.feedCategorySeriesDetailModel?.description ?? ""))
                                .environmentObject(feedViewModel)
                            
                            

                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("EPISODES")
                                .font(.custom(Font.semiBold, size: 18))
                                .foregroundStyle(Color.white)
                            
                            VStack(spacing: 5) {
                                ForEach(feedViewModel.feedCategorySeriesDetailModel?.sessions ?? [], id: \.uid) { data in
                                    ForEach(data.episodes ?? [], id: \.uid) { episode in
                                        EpisodesView(seriesImage: episode.thumbnail, episode: "S\(episode.session_number):E\(episode.episode_number)", title: episode.title, description: episode.description, icon: "download") {
                                            redirectVideoPlayer = true
//                                            seriesEpisodeDetailId = episode.uid
                                        }
                                        
                                        NavigationLink(isActive: $redirectVideoPlayer) {
                                            VideoPlayerView(seriesEpisodeDetailId: episode, seriesDetailID: $seriesDetailID)
                                                .environmentObject(feedViewModel)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            EmptyView()
                                        }
                                        
                                        NavigationLink(isActive: $redirectVideoPlayerWithEpisode) {
                                            VideoPlayerView(seriesEpisodeDetailId: episode, seriesDetailID: $seriesDetailID)
                                                .environmentObject(feedViewModel)
                                                .navigationBarBackButtonHidden(true)
                                        } label: {
                                            EmptyView()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                    
                    //
                }
            }
            
            if feedViewModel.showLoader {
                FLLoader()
            }
        }
        .onAppear {
            feedViewModel.getFeedCategorySeriesDetail(id: seriesDetailID)
            print("series detail id --> ", seriesDetailID)
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    EpisodeDetailView(seriesDetailID: .constant(""))
}
