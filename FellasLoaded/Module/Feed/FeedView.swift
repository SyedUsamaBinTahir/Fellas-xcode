//
//  FeedView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct FeedView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var redirectContinueWatchingDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack(alignment: .center) {
                        Image("search-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Spacer()
                        Image("fellas-loaded-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 98, height: 42, alignment: .center)
                            .clipped()
                        Spacer()
                        Image("notifications")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .padding()
                    ScrollView {
                        Image("banner")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .padding(.top)
                        
                        VStack(spacing: 20) {
                            FeedSwiperView(title: "Specials", feedImage: "series-image", width: horizontalSizeClass == .regular ? 304 : 155, height: horizontalSizeClass == .regular ? 456 : 232) {
                                redirectContinueWatchingDetail = true
                            }
                            FeedSwiperView(title: "Recently added", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155) {
                                
                            }
                            FeedSwiperView(title: "Continue watching", feedImage: "series-image", description: "The Beer Mile!" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155, progressBarValue: 5) {
                                
                            }
                            FeedSwiperView(title: "Series", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171) {
//                                redirectContinueWatchingDetail = true
                            }
                            FeedSwiperView(title: "Bonus Content", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171) {
//                                redirectContinueWatchingDetail = true
                            }
                            FeedSwiperView(title: "Podcasts", feedImage: "series-image", width: horizontalSizeClass == .regular ? 195 : 114, height: horizontalSizeClass == .regular ? 292 : 171) {
//                                redirectContinueWatchingDetail = true
                            }
                            FeedSwiperView(title: "Most Popular", feedImage: "series-image", description: "The Fellas & W2S Get Drunk in Amsterdam Holland" ,width: horizontalSizeClass == .regular ? 523 : 277, height: horizontalSizeClass == .regular ? 294 : 155) {
                                
                            }
                        }
                        .padding()
                    }

                }
                .padding(.top, 30)
                
                .navigationDestination(isPresented: $redirectContinueWatchingDetail) {
                    ContinueWatchingDetailView().navigationBarBackButtonHidden(true)
                }
                
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        .ignoresSafeArea()
        }
    }
}

#Preview {
    FeedView()
}
