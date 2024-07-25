//
//  MediaUpdatesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct MediaUpdatesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var liveStramToggle = false
    @State private var EpisodesToggle = false
    @State private var upcommingSeriesToggle = false
    @State private var valutToggle = false
    @State private var shop = false
    @State private var redirectSubscriptionSeries = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(Circle())
                        }).padding(.leading)
                        
                        Spacer()
                    }
                    
                    if horizontalSizeClass != .regular {
                        HStack {
                            Text("Media Updates")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Medi aUpdates")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsToggleButtonView(icon: nil, title: "Live Streams", description: "Notify me when a live stream starts.", toggle: $liveStramToggle)
                                SettingsToggleButtonView(icon: nil, title: "Episodes", description: "Notify me about all new general episodes.", toggle: $EpisodesToggle)
                                SettingsNavigatorView(icon: nil, title: "Subscribed series", description: "Tap to manage push notifications for each series you subscribed to.", forwardIcon: "chevron.right") { redirectSubscriptionSeries = true }
                                SettingsToggleButtonView(icon: nil, title: "Upcoming releases", description: "Notify me a week prior upcoming releases.", toggle: $upcommingSeriesToggle)
                                SettingsToggleButtonView(icon: nil, title: "Vault", description: "Notify me when new Vault content is uploaded.", toggle: $valutToggle)
                                SettingsToggleButtonView(icon: nil, title: "Shop", description: "Notify me when new merchandise is added.", toggle: $shop)
                            }
                            .padding(.top)
                        }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                                
                Spacer()
            }
//            .navigationDestination(isPresented: $redirectSubscriptionSeries) {
//                SubscribesSeriesView().navigationBarBackButtonHidden(true)
//            }
            
            NavigationLink(isActive: $redirectSubscriptionSeries) {
                SubscribesSeriesView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }

        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MediaUpdatesView()
}
