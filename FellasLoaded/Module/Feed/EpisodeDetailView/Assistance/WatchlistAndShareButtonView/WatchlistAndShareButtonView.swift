//
//  WatchlistAndShareButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import SwiftUI

struct WatchlistAndShareButtonView: View {
    @State var watchlistAction: () -> Void = {}
    @State var shareAction: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Button (action: watchlistAction) {
                    Image("add-to-watchlist-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                
                Button (action: shareAction) {
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
    WatchlistAndShareButtonView()
}
