//
//  DownloadVideoUrlsView.swift
//  FellasLoaded
//
//  Created by Syed Usama on 15/07/2024.
//

import SwiftUI

struct DownloadVideoUrlsView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                
                HStack {
                    Text("Download")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                }
                
                HStack {
                    Spacer()

                    Button(action: {
                        
                    }, label: {
                        Image("xmark-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    })
                    
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading ,spacing: 30) {
                ForEach(feedViewModel.seriesEpisodeDetailModel?.bvideo.download_urls?.compactMap { $0 } ?? [], id: \.key) { key, downloadURL in
                    Button(action: action) {
                        Text(key)
                            .font(.custom(Font.semiBold, size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .foregroundStyle(.white)
            Spacer()
            VStack(spacing: 12) {
                Rectangle()
                    .fill(Color.theme.appGrayColor)
                    .frame(height: 1)
                Text("This selection only applies to the current video")
                    .font(.custom(Font.Medium, size: 12))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            .padding(.top)
            
            Spacer()
        }
        .onAppear {
            
        }
        .padding()
        .background(Color.theme.tabbarColor)
        .ignoresSafeArea()
    }
}

#Preview {
    DownloadVideoUrlsView(action: {})
}
