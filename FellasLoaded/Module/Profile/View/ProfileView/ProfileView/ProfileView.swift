//
//  ProfileView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State private var redirectSettings = false
    @State private var redirectDownloads = false
    @State private var redirectWatchlist = false
    
    var body: some View {
        VStack {
            SettingsButtonView(redirectSettings: $redirectSettings)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ProfileImageView(profileImage: .constant(feedViewModel.userDetailModel?.avatar ?? ""),
                                     name: .constant(feedViewModel.userDetailModel?.name ?? ""))
                    
                    MembershipCardView {  }
                    
                    if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                        VStack(spacing: 14) {
                            SettingsNavigatorView(icon: "download", title: "Downloads", description: nil, forwardIcon: "chevron-icon") {
                                redirectDownloads = true
                            }
                            SettingsNavigatorView(icon: "watchlist-icon", title: "Watchlist ", description: nil, forwardIcon: "chevron-icon") {
                                redirectWatchlist = true
                            }
                            
                            ConfesstionBoxButtonView {  }
                                .disabled(true)
                            
                        }
                        .padding(.top)
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                NavigationLink(isActive: $redirectSettings) {
                    SettingsView(userEmail: .constant(feedViewModel.userDetailModel?.email ?? "")).navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $redirectDownloads) {
                    DownloadsView().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $redirectWatchlist) {
                    WatchlistView().navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
            }
        }
        .onAppear {
            feedViewModel.getUserDetail()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
