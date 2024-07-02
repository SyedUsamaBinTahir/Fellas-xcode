//
//  ContinueWatchingDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct ContinueWatchingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var title: String = ""
    @State var episodeID: String = ""
    @State private var redirectVideoPlayer = false
    @State private var seriesDetailID: String = ""
    @State private var episodeCategoryID: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 30) {
                    
                    ContinueWatchingDetailHeaderView(title: $title)
                    
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(feedViewModel.feedCategoryEpisodesModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail, episode: "\(data.session_number):\(data.episode_number)", title: data.title, description: data.description, icon: "download") {
                                    redirectVideoPlayer = true
                                    episodeCategoryID = data.uid
                                }
                                
                                NavigationLink(isActive: $redirectVideoPlayer) {
                                    VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: episodeCategoryID, feedCategoryEpisodeId: data)
                                        .environmentObject(feedViewModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    feedViewModel.getCategoryEpisodes(id: episodeID)
                    print("Episode ID --> ", episodeID)
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
    ContinueWatchingDetailView()
}
