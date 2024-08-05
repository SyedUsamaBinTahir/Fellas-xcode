//
//  EpisodeDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import ExytePopupView

struct EpisodeDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var feedCategorySeriesDetailModel: FeedCategorySeriesDetailModel?
    @State private var redirectVideoPlayer = false
//    @State private var redirectVideoPlayerWithEpisode = false
    @State var seriesEpisodeDetailId: String = ""
    @Binding var seriesDetailID: String
    
    @State private var selectedEpisode: FeedCategoryEpisodesResults? = nil
    
    var body: some View {
        VStack {
            
            if let episode = self.selectedEpisode {
                NavigationLink(isActive: $redirectVideoPlayer) {
                    VideoPlayerView(seriesEpisodeDetailId: episode, seriesDetailID: $seriesDetailID)
                        .environmentObject(feedViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
            }
//            if feedViewModel.showLoader {
//                FLLoader()
//            } else {
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
                    
                    VStack(alignment: .leading, spacing: 16) {
                        if horizontalSizeClass != .regular {
                            if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                                Button {
                                    self.selectedEpisode = feedViewModel.feedCategorySeriesDetailModel?.sessions?.first?.episodes?.first
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        redirectVideoPlayer = true
                                    }
                                    
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
                                    .cornerRadius(8)
                                }
                            } else {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image("lock-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                        Text("BECOME A MEMBER")
                                            .font(.custom(Font.bold, size: 16))
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .frame(height: 48)
                                    .background(Color.theme.appGrayColor)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(8)
                                }
                            }
                            
                            WatchlistAndShareButtonView(Loader: $feedViewModel.showButtonLoader, watchlistAdded: $feedViewModel.watchListAdded, watchlistAction: {
                                feedViewModel.showButtonLoader = true
                                feedViewModel.addSeriesWatchLater(seriesUid: seriesDetailID)
                            }, removeWatchlist: {
                                feedViewModel.showButtonLoader = true
                                feedViewModel.removeSeriesWatchLater(seriesUid: seriesDetailID)
                            })
                            
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
                                            self.selectedEpisode = episode
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                redirectVideoPlayer = true
                                            }
                                            //                                            seriesEpisodeDetailId = episode.uid
                                        }
                                        
//                                        NavigationLink(isActive: $redirectVideoPlayer) {
//                                            VideoPlayerView(seriesEpisodeDetailId: episode, seriesDetailID: $seriesDetailID)
//                                                .environmentObject(feedViewModel)
//                                                .navigationBarBackButtonHidden(true)
//                                        } label: {
//                                            EmptyView()
//                                        }
//                                        
//                                        NavigationLink(isActive: $redirectVideoPlayerWithEpisode) {
//                                            VideoPlayerView(seriesEpisodeDetailId: data.episodes?.first, seriesDetailID: $seriesDetailID)
//                                                .environmentObject(feedViewModel)
//                                                .navigationBarBackButtonHidden(true)
//                                        } label: {
//                                            EmptyView()
//                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                }
//            }
        }
        .popup(isPresented: $feedViewModel.watchListSuccess) {
            FLToastAlert(image: .constant("popup-success-icon"), message: .constant("Added to watchlist"))
        } customize: {
            $0
                .type(.floater(useSafeAreaInset: true))
                .position(.top)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
                .autohideIn(3)
                .appearFrom(.top)
        }
        .popup(isPresented: $feedViewModel.watchListRemovedSuccess) {
            FLToastAlert(image: .constant("popup-success-icon"), message: .constant("Removed from watchlist"))
        } customize: {
            $0
                .type(.floater(useSafeAreaInset: true))
                .position(.top)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
                .autohideIn(3)
                .appearFrom(.top)
        }
        .popup(isPresented: $feedViewModel.showAlert) {
            FLToastAlert(image: .constant("popup-failure-icon"), message: .constant(feedViewModel.alertMessage))
        } customize: {
            $0
                .type(.floater(useSafeAreaInset: true))
                .position(.top)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.5))
                .autohideIn(3)
                .appearFrom(.top)
        }
        .onAppear {
            feedViewModel.showLoader = true
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
