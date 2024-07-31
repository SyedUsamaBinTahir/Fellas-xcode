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
    @State var redirectWatchlistEpisodes = false
    @State var watchlistSeriesId = ""
    
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
                            ForEach(viewModel.watchlaterSeriesModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail, episode: "\(data.sessions_count):\(data.episodes_count)", title: data.title, description: data.description ?? "", icon: "chevron-icon") {
                                    watchlistSeriesId = data.uid
                                    redirectWatchlistEpisodes = true
                                }
                                
                                NavigationLink(destination: WatchListEpisodesView(watchlistSeriesId: watchlistSeriesId).navigationBarBackButtonHidden(true), isActive: $redirectWatchlistEpisodes) {
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
            viewModel.getWatchLaterSeries()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    WatchlistSeriesView()
}
