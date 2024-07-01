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
    @State var episodeCategoryID: String?
    @State var seriesUid: CategoriesResults?
    @State var feedCategoryEpisodeId: FeedCategoryEpisodesResults?
    @State var feedSearchEpisodeId: FeedSearchResults?
    
    var body: some View {
        ZStack {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                if let url = URL(string: feedViewModel.seriesEpisodeDetailModel?.bvideo.hls_video_playlist_url ?? "") {
                    VideoPlayer(size: size, safeArea: safeArea, url: url, commentOrder: $commentOrder)
                        .environmentObject(feedViewModel)
                        .ignoresSafeArea()
                }
                else {
                    FLLoader()
                }
                
            }
            .onChange(of: commentOrder) { _ in
                feedViewModel.showLoader = true
                if seriesEpisodeDetailId != nil {
                    feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                    print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
                } else {
                    feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                    print("Episode Comments ID -->", episodeCategoryID ?? "")
                }
            }
            .onAppear {
                feedViewModel.showLoader = true
                if seriesEpisodeDetailId != nil {
                    feedViewModel.getSeriesEpisodeDetail(id: seriesEpisodeDetailId?.uid ?? "")
                    print("Series Episode Detail ID -->", seriesEpisodeDetailId?.uid ?? "")
                } else {
                    feedViewModel.getSeriesEpisodeDetail(id: episodeCategoryID ?? "")
                    print("Episode Detail ID -->", episodeCategoryID ?? "")
                }
                
                if seriesUid != nil {
                    feedViewModel.getFeedCategorySeriesDetail(id: seriesUid?.seriesUid ?? "")
                    print("Series ID -->",  seriesUid?.seriesUid ?? "")
                } else if feedCategoryEpisodeId != nil {
                    feedViewModel.getFeedCategorySeriesDetail(id: feedCategoryEpisodeId?.series_uid ?? "")
                    print("Series ID -->",  feedCategoryEpisodeId?.series_uid ?? "")
                } else if feedSearchEpisodeId != nil {
                    feedViewModel.getFeedCategorySeriesDetail(id: feedSearchEpisodeId?.seriesUid ?? "")
                    print("Series ID -->",  feedSearchEpisodeId?.seriesUid ?? "")
                } else {
                    feedViewModel.getFeedCategorySeriesDetail(id: seriesDetailID)
                    print("Series Detail ID -->", seriesDetailID)
                }
                
                if seriesEpisodeDetailId != nil {
                    feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                    print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
                } else {
                    feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                    print("Episode Comments ID -->", episodeCategoryID ?? "")
                }
                
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
