//
//  WatchlistAndShareButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import SwiftUI

struct WatchlistAndShareButtonView: View {
    let url = URL(string: "https://www.hackingwithswift.com")!
    @Binding var Loader: Bool
    @Binding var watchlistAdded: Bool
    @State var watchlistAction: () -> Void = {}
    @State var removeWatchlist: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                    if !watchlistAdded {
                        Button (action: watchlistAction) {
                            if Loader {
                                ZStack {
                                    FLButtonLoader(color: .constant(Color.white))
                                }
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(.circle)
                                .frame(width: 40, height: 40)
                            } else {
                                Image("add-to-watchlist-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    } else {
                        Button (action: removeWatchlist) {
                            if Loader {
                                ZStack {
                                    FLButtonLoader(color: .constant(Color.white))
                                }
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(.circle)
                                .frame(width: 40, height: 40)
                            } else {
                                ZStack {
                                    Image("watchlist-added-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(.circle)
                                .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
                
                ShareLink(item: url) {
                    Image("ep-detail-share-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            }
            
            Rectangle()
                .fill(Color.theme.appGrayColor.opacity(0.4))
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
}

#Preview {
    WatchlistAndShareButtonView(Loader: .constant(false), watchlistAdded: .constant(false))
}
