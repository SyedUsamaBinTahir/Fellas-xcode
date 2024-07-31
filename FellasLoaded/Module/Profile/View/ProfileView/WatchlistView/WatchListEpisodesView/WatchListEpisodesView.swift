//
//  WatchListEpisodesView.swift
//  FellasLoaded
//
//  Created by Syed Usama on 31/07/2024.
//

import SwiftUI

struct WatchListEpisodesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProfileViewModel(_dataService: GetServerData.shared)
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var watchlistSeriesId: String?
    
    @State private var redirectVideoPlayer = false
    @State var seriesDetailID = ""
    @State var watchlistEpisodeId =  ""
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 30) {
                    ZStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image("back-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            })
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text("Watchlist")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                        
                        HStack {
                            Spacer()

                            Button(action: {
                                
                            }, label: {
                                Image("edit-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            })
                            
                        }
                    }
                    .padding(.top, 30)
                    
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.watchLaterEpisodesModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail,
                                             episode: "\(data.session_number):\(data.episode_number)",
                                             title: data.title,
                                             description: "",
                                             icon: "download-icon") {
                                    watchlistEpisodeId = data.uid
                                    redirectVideoPlayer = true
                                }
                                
                                NavigationLink(isActive: $redirectVideoPlayer) {
                                    VideoPlayerView(seriesDetailID: $seriesDetailID, episodeCategoryID: watchlistEpisodeId, watchlistSeriesId: data)
                                        .environmentObject(viewModel)
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
                
                if viewModel.showLoader {
                    FLLoader()
                }
            }
        }
        .onAppear {
            viewModel.showLoader = true
            viewModel.getWatchLaterEpisodes(id: watchlistSeriesId ?? "")
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WatchListEpisodesView()
}
