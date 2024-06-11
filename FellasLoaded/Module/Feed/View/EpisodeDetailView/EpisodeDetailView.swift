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
    var feedCategorySeriesDatailModel: FeedCategorySeriesDetailModel?
    @Binding var seriesDetailID: String
    
    var body: some View {
        VStack {
            ZStack {
                ScrollView {
                    ZStack(alignment: horizontalSizeClass == .regular ? .topLeading : .center) {
                        if horizontalSizeClass == .regular {
                            EpisodesDetailImageView(image: .constant(feedViewModel.feedCategorySeriesDatailModel?.horizontal_cover_photo ?? ""))
                        } else {
                            EpisodesDetailImageView(image: .constant(feedViewModel.feedCategorySeriesDatailModel?.vertical_cover_photo ?? ""))
                        }
                        
                        VStack(alignment: horizontalSizeClass == .regular ? .leading : .center) {
                            EpisodesDetaulBackButtonView()
                            
                            if horizontalSizeClass != .regular {
                                Spacer()
                                
                                
                                EpisodesDetailLogoView(logo: .constant(feedViewModel.feedCategorySeriesDatailModel?.logo ?? ""))
                            }
                            
                            if horizontalSizeClass == .regular {
                                VStack(alignment: .leading, spacing: 16) {
                                    EpisodesDetailLogoView(logo: .constant(feedViewModel.feedCategorySeriesDatailModel?.logo ?? ""))
                                    
                                    PlayButtonView {  }
                                    
                                    EpisodesDetailDescriptionView(seasonNumber: .constant("S\(feedViewModel.feedCategorySeriesDatailModel?.sessions_count ?? 0): E\(feedViewModel.feedCategorySeriesDatailModel?.episodes_count ?? 0)"), desctiption: .constant(feedViewModel.feedCategorySeriesDatailModel?.description ?? ""))
                                        .environmentObject(feedViewModel)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.60)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .frame(height: 488)
                    .padding(.top, 50)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        if horizontalSizeClass != .regular {
                            Button {
                                
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
                            
                            EpisodesDetailDescriptionView(seasonNumber: .constant("S\(feedViewModel.feedCategorySeriesDatailModel?.sessions_count ?? 0): E\(feedViewModel.feedCategorySeriesDatailModel?.episodes_count ?? 0)"), desctiption: .constant(feedViewModel.feedCategorySeriesDatailModel?.description ?? ""))
                                .environmentObject(feedViewModel)
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("EPISODES")
                                .font(.custom(Font.semiBold, size: 18))
                                .foregroundStyle(Color.white)
                            
                            VStack(spacing: 20) {
                                ForEach(feedViewModel.feedCategorySeriesDatailModel?.sessions ?? [], id: \.uid) { data in
                                    ForEach(data.episodes ?? [], id: \.uid) { episode in
                                        EpisodesView(seriesImage: episode.series_thumbnail, episode: "S\(episode.session_number):E\(episode.episode_number)", title: episode.title, description: episode.description, icon: "download")
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                    
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
        .ignoresSafeArea()
    }
}

#Preview {
    EpisodeDetailView(seriesDetailID: .constant(""))
}