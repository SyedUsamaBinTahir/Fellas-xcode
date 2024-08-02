//
//  WatchlistView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct WatchlistSeriesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProfileViewModel(_dataService: GetServerData.shared)
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var seriesWatchListId = ""
    @State var redirectWatchlistEpisodes = false
    @State var deleteWatchList = false
    @State var watchlistSeriesId = ""
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 30) {
                    ZStack {
                        HStack {
                            if deleteWatchList {
                                Button(action: {
                                    deleteWatchList = false
                                }, label: {
                                    Image("xmark-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                })
                            } else {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image("back-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                })
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 10)
                        
                        HStack {
                            Text(deleteWatchList ? "Select Items" : "Watchlist")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                        
                        HStack {
                            Spacer()
                            if deleteWatchList {
                                Button(action: {
                                    feedViewModel.removeSeriesWatchLater(seriesUid: seriesWatchListId)
                                }, label: {
                                    Image("delete-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                })
                            } else {
                                Button(action: {
                                    deleteWatchList = true
                                }, label: {
                                    Image("edit-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                })
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.bottom)
                    .background(deleteWatchList ? Color.theme.appGrayColor : Color.clear)
 
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.watchlaterSeriesModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail, episode: "\(data.sessions_count):\(data.episodes_count)", title: data.title, description: data.description ?? "", icon: deleteWatchList ? "select-watch-later" : "chevron-icon", action: {
                                    if !deleteWatchList {
                                        watchlistSeriesId = data.uid
                                        redirectWatchlistEpisodes = true
                                    }
                                }, selectedWatchLaterIdAction: {
                                    seriesWatchListId = data.uid
                                })
                                
                                NavigationLink(destination: WatchListEpisodesView(watchlistSeriesId: watchlistSeriesId).navigationBarBackButtonHidden(true), isActive: $redirectWatchlistEpisodes) {
                                    EmptyView()
                                }
                            }
                        }
                        .padding()
                    }
                }
                
                if viewModel.showLoader {
                    FLLoader()
                }
            }
        }
        .onAppear {
            viewModel.showLoader = true
            viewModel.getWatchLaterSeries()
        }
        .onReceive(feedViewModel.$watchListRemovedSuccess) { _ in
            viewModel.showLoader = true
            viewModel.getWatchLaterSeries()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    WatchlistSeriesView()
}
