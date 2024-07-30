//
//  SearchView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var search: String = ""
    @State var isSearching: Bool = false
    @State private var redirectVideoPlayer = false
    @State private var redirectSeriesDetail = false
    @State private var seriesDetailID: String = ""
    @State private var episodeCategoryID: String = ""
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 16) {
                SearchTextFieldView(search: $search, isSearching: $isSearching)
                
                if feedViewModel.showLoader {
                    FLLoader()
                } else {
                    SearchResultAndRecommentdTextView(isSearching: $isSearching)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(feedViewModel.feedSearchModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail, episode: "S\(data.sessionNumber ?? 0):E\(data.episodeNumber ?? 0)", title: data.title, description: data.description, icon: data.recommendedType == "episode" ? "download" : "chevron-icon") {
                                    if data.recommendedType == "episode" {
                                        redirectVideoPlayer = true
                                        episodeCategoryID = data.uid
                                    } else if data.recommendedType == "series" {
                                        redirectSeriesDetail = true
                                        seriesDetailID = data.uid
                                    }
                                }
                                
                                NavigationLink(isActive: $redirectVideoPlayer) {
                                    VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: episodeCategoryID, feedSearchEpisodeId: data)
                                        .environmentObject(feedViewModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    EmptyView()
                                }
                                
                                NavigationLink(isActive: $redirectSeriesDetail) {
                                    EpisodeDetailView(seriesDetailID: $seriesDetailID)
                                        .environmentObject(feedViewModel)
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .onChange(of: search) { result in
                feedViewModel.showLoader = true
                feedViewModel.getFeedSearchList(searchParam: "?search=\(result)")
            }
            .onAppear {
                feedViewModel.showLoader = true    
                feedViewModel.getFeedSearchList(searchParam: "")
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SearchView()
}
