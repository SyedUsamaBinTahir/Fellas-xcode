//
//  VideoPlayerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct VideoPlayerView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State var seriesEpisodeDetailId: FeedCategoryEpisodesResults?
    @State var commentOrder: String = ""
    @Binding var seriesDetailID: String
    @State private var episodeDetail: SeriesEpisodeDetailModel? = nil
    var body: some View {
        ZStack {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                if let urlString = feedViewModel.seriesEpisodeDetailModel?.bvideo.hls_video_playlist_url,
                   let url = URL(string: urlString) {
                    VideoPlayer(size: size, safeArea: safeArea, url: url, commentOrder: $commentOrder)
                        .environmentObject(feedViewModel)
                        .ignoresSafeArea()
                } else {
                    Text("Failed to load video")
                }
                
            }
            .onChange(of: commentOrder) { _ in
                feedViewModel.showLoader = true
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            }
            .onAppear {
                feedViewModel.showLoader = true
                feedViewModel.getSeriesEpisodeDetail(id: seriesEpisodeDetailId?.uid ?? "")
                print("Series Episode Detail ID -->", seriesEpisodeDetailId?.uid ?? "")
                
                feedViewModel.getFeedCategorySeriesDetail(id: seriesDetailID)
                print("Series Detail ID -->", seriesDetailID)
                
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
                
            }
            
            if feedViewModel.showLoader {
                FLLoader()
            }
        }
    }
    
}

//#Preview {
//    VideoPlayerView(seriesEpisodeDetailId: .constant(""), seriesDetailID: .constant(""))
//}
