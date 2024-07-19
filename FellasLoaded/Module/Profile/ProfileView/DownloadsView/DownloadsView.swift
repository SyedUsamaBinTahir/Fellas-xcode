//
//  DownloadsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct DownloadsView: View {
    var feedSeriesEpisodeDetailModel: SeriesEpisodeDetailModel?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
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
                        Text("Downloads")
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
//                        ForEach(1...5, id: \.self) { data in
//                            EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why", icon: "downloaded-icon")
//                        }
                        DownloadedFilesView()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            guard let data = UserDefaults.standard.data(forKey: FLUserDefaultKeys.videoData.rawValue) else {
                return
            }
            
            do {
                let decoder = try JSONDecoder().decode([SeriesBvideo].self, from: data)
                print(decoder)
            } catch {
                print(String(describing: error))
            }
            
            print("User defaults data -->", String(data: data, encoding: .utf8) ?? "")
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DownloadsView()
}
