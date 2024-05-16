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
                    Image("png-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.40 : 488)
                    VStack(alignment: horizontalSizeClass == .regular ? .leading : .center) {
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
                        .padding()
                        
                        if horizontalSizeClass != .regular {
                            Spacer()
                            
                            
                            Image("logo-for-series")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 203, height: 125)
                                .padding()
                        }
                        
                        if horizontalSizeClass == .regular {
                            VStack(alignment: .leading, spacing: 16) {
                                Image("logo-for-series")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 203, height: 125)
                                    .padding()
                                
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
                                    .frame(width: 300,height: 48)
                                    .background(Color.white)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                }
                                
                                Text("S1: E22.2022")
                                    .font(.custom(Font.Medium, size: 14))
                                    .foregroundStyle(Color.white)
                                
                                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis p")
                                    .font(.custom(Font.regular, size: 14))
                                    .foregroundStyle(Color.white)
                                
                                Text("Hosts: Cal, and Chip  ")
                                    .font(.custom(Font.Medium, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
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
                        
                        Text("S1: E22.2022")
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.white)
                        
                        Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis p")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.white)
                        
                        Text("Hosts: Cal, and Chip  ")
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("EPISODES")
                            .font(.custom(Font.semiBold, size: 18))
                            .foregroundStyle(Color.white)
                        
                        VStack(spacing: 20) {
                            ForEach(1...5, id: \.self) { data in
                                EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why")
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
