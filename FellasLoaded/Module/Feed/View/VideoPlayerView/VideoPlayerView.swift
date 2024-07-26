//
//  VideoPlayerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct VideoPlayerView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State var videoURL: URL?
    @State var seriesEpisodeDetailId: FeedCategoryEpisodesResults?
    @State var commentOrder: String = ""
    @Binding var seriesDetailID: String
    @State private var episodeDetail: SeriesEpisodeDetailModel? = nil
    @State var episodeCategoryID: String?
    @State var seriesUid: CategoriesResults?
    @State var feedCategoryEpisodeId: FeedCategoryEpisodesResults?
    @State var feedSearchEpisodeId: FeedSearchResults?
    @State var bannerUid: FeedBannerResults?
    @State var reloadVideo = false
    @State var episodeSeriesUid: String?
    
    var body: some View {
        VStack {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                if let videoURL = videoURL {
                    VideoPlayer(size: size,
                                safeArea: safeArea,
                                url: videoURL,
                                commentOrder: $commentOrder,
                                seriesEpisodeDetailId: .constant(seriesEpisodeDetailId?.uid ?? ""),
                                episodeCategoryID: .constant(episodeCategoryID ?? ""),
                                bannerUid: .constant(bannerUid?.object_uid ?? ""),
                                reloadVideo: $reloadVideo,
                                episodeSeriesUid: $episodeSeriesUid)
                    .environmentObject(feedViewModel)
                    .ignoresSafeArea()
                }
                else {
                    FLLoader()
                }
                
            }
        }
        .onChange(of: commentOrder) { _ in
            feedViewModel.showLoader = true
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodesComments(id: bannerUid?.object_uid ?? "", commentOrderBy: commentOrder)
                print("Series comments banner uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                print("Episode Comments ID -->", episodeCategoryID ?? "")
            }
        }
        .onReceive(feedViewModel.$commentCreated) { _ in
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodesComments(id: bannerUid?.object_uid ?? "", commentOrderBy: commentOrder)
                print("Series comments banner uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                print("Episode Comments ID -->", episodeCategoryID ?? "")
            }
        }
        .onReceive(feedViewModel.$commentDeleted) { _ in
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodesComments(id: bannerUid?.object_uid ?? "", commentOrderBy: commentOrder)
                print("Series comments banner uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                print("Episode Comments ID -->", episodeCategoryID ?? "")
            }
        }
        .onReceive(feedViewModel.$likeCommentAdded) { _ in
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodesComments(id: bannerUid?.object_uid ?? "", commentOrderBy: commentOrder)
                print("Series comments banner uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                print("Episode Comments ID -->", episodeCategoryID ?? "")
            }
        }
        .onChange(of: reloadVideo) { _ in
            // issue: video url is not changing
            feedViewModel.showLoader = true
            feedViewModel.getSeriesEpisodeDetail(id: episodeSeriesUid ?? "") { url in
                self.videoURL = url
            }
            print("reload url -->", self.videoURL ?? "")
            print("Episode series Uid -->", episodeSeriesUid ?? "")
            reloadVideo = false
            
            feedViewModel.getSeriesEpisodesComments(id: episodeSeriesUid ?? "", commentOrderBy: commentOrder)
            print("Series Episode Comments ID -->", episodeSeriesUid ?? "")
        }
        .onAppear {
            feedViewModel.showLoader = true
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodeDetail(id: seriesEpisodeDetailId?.uid ?? "") { url in
                    self.videoURL = url
                }
                print("Series Episode Detail ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodeDetail(id: bannerUid?.object_uid ?? "") { url in
                    self.videoURL = url
                }
                print("Banner Uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodeDetail(id: episodeCategoryID ?? "") { url in
                    self.videoURL = url
                    print("url --> ", self.videoURL ?? "")
                }
                print("Episode Detail ID -->", episodeCategoryID ?? "")
            }
            
            if seriesEpisodeDetailId != nil {
                feedViewModel.getSeriesEpisodesComments(id: seriesEpisodeDetailId?.uid ?? "", commentOrderBy: commentOrder)
                print("Series Episode Comments ID -->", seriesEpisodeDetailId?.uid ?? "")
            } else if bannerUid != nil {
                feedViewModel.getSeriesEpisodesComments(id: bannerUid?.object_uid ?? "", commentOrderBy: commentOrder)
                print("Series comments banner uid -->", bannerUid?.object_uid ?? "")
            } else {
                feedViewModel.getSeriesEpisodesComments(id: episodeCategoryID ?? "", commentOrderBy: commentOrder)
                print("Episode Comments ID -->", episodeCategoryID ?? "")
            }
            
            if seriesUid != nil {
                // Feed Episodes list
                feedViewModel.getFeedCategorySeriesDetail(id: seriesUid?.seriesUid ?? "")
                print("Series ID -->",  seriesUid?.seriesUid ?? "")
            } else if feedCategoryEpisodeId != nil {
                // Feed Episodes Detail page episodes list
                feedViewModel.getFeedCategorySeriesDetail(id: feedCategoryEpisodeId?.series_uid ?? "")
                print("Series ID -->",  feedCategoryEpisodeId?.series_uid ?? "")
            } else if feedSearchEpisodeId != nil {
                // Feed Search Episodes list
                feedViewModel.getFeedCategorySeriesDetail(id: feedSearchEpisodeId?.seriesUid ?? "")
                print("Series ID -->",  feedSearchEpisodeId?.seriesUid ?? "")
            } else if bannerUid != nil {
                // Feed banner Episodes List
                feedViewModel.getFeedCategorySeriesDetail(id: "6c9fd73e-59c6-4018-9cea-afcfd995f78f")
                print("Series Detail ID -->", seriesDetailID)
            } else {
                // Feed Series Episodes list
                feedViewModel.getFeedCategorySeriesDetail(id: seriesDetailID)
                print("Series Detail ID -->", seriesDetailID)
            }
            
            feedViewModel.getFeedSearchList(searchParam: "")
                    
        }
    }
}

//#Preview {
//    VideoPlayerView(seriesEpisodeDetailId: .constant(""), seriesDetailID: .constant(""))
//}
