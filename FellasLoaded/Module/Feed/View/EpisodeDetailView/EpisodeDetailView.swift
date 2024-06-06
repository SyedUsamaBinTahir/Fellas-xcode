//
//  EpisodeDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI

struct EpisodeDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: horizontalSizeClass == .regular ? .topLeading : .center) {
                    EpisodesDetailImageView(image: .constant("png-image"))
                    
                    VStack(alignment: horizontalSizeClass == .regular ? .leading : .center) {
                        EpisodesDetaulBackButtonView()
                        
                        if horizontalSizeClass != .regular {
                            Spacer()
                            
                            
                            EpisodesDetailLogoView(logo: .constant("logo-for-series"))
                        }
                        
                        if horizontalSizeClass == .regular {
                            VStack(alignment: .leading, spacing: 16) {
                                EpisodesDetailLogoView(logo: .constant("logo-for-series"))
                                
                                PlayButtonView {  }
                                
                                EpisodesDetailDescriptionView(seasonNumber: .constant("S1: E22.2022"), desctiption: .constant("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis p"), host: .constant("Cal, and Chip"))
                            }
                            .frame(width: UIScreen.main.bounds.width * 0.60)
                            .padding(.horizontal)
                        }
                    }
                }
                .frame(height: 488)
                .padding(.top, 50)
                
                VStack(alignment: .leading, spacing: 16) {
                    if horizontalSizeClass != .regular {
                        Button {
                            
                        } label: {
                            HStack {
                                Image("play-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                Text("PLAY")
                                    .font(.custom(Font.bold, size: 16))
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 48)
                            .background(Color.white)
                            .foregroundColor(Color.black)
                            .cornerRadius(10)
                        }
                        
                        WatchlistAndShareButtonView(watchlistAction: {}, shareAction: {})
                        
                        EpisodesDetailDescriptionView(seasonNumber: .constant("S1: E22.2022"), desctiption: .constant("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis p"), host: .constant("Cal, and Chip"))
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("EPISODES")
                            .font(.custom(Font.semiBold, size: 18))
                            .foregroundStyle(Color.white)
                        
                        VStack(spacing: 20) {
                            ForEach(1...5, id: \.self) { data in
                                EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why", icon: "download")
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EpisodeDetailView()
}
