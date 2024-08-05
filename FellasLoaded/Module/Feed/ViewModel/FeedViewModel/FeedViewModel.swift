//
//  FeedViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation
import Combine
import Alamofire

protocol FeedDataProvider {
    func getFeedBanners()
    func getFeedCategories()
    func getFeedCategorySeries(id: String)
    func getCategoryEpisodes(id: String)
    func getFeedCategorySeriesDetail(id: String)
    func getSeriesEpisodeDetail(id: String, completion: @escaping (URL?) -> Void)
    func getSeriesEpisodesComments(id: String, commentOrderBy: String)
    func getSeriesEpisodesCommentsDetail(id: String)
    func getFeedSeriesEpisodes(id: String)
    func getFeedSearchList(searchParam: String)
    func createComment(episode: String, comment: String)
    func deleteComment(commentUid: String)
    func editComment(commentUid: String, comment: String)
    func createReplies(episode: String, parent: String, replyTo: String, comment: String)
    func addSeriesWatchLater(seriesUid: String)
    func removeSeriesWatchLater(seriesUid: String)
    func addEpisodeWatchLater(episodeUid: String)
    func removeEpisodeWatchLater(episodeUid: String)
    func likeCommnet(comment: String)
    func deleteLikeComment(comment: String)
}

class FeedViewModel: ObservableObject {
    // Dependency for GetDataService class
    private let dataService: DataServiceBased
    
    init(_dataService: DataServiceBased) {
        self.dataService = _dataService
    }
    
    // Cancel Subscription after success
    var subscriptions = Set<AnyCancellable>()
    
    // show Loader and alerts after api calls properties
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var showButtonLoader = false
    
    // this will reload the comments after new comment is created
    @Published var commentCreated = false
    
    // watch list success popup
    @Published var watchListAdded = false
    @Published var watchListRemoved = false
    // changes watchlist icon after success
    @Published var watchListSuccess = false
    @Published var watchListRemovedSuccess = false
    // comments properties
    @Published var likeCommentAdded = false
    @Published var commentDeleted = false
    @Published var commentEdited = false
    @Published var editCommentTapped = false
    
    // Api Models
    var feedBannerModel: FeedBannerModel?
    var feedCategoriesModel: FeedCategoriesModel?
    var feedCategorySeriesModel: FeedCategorySeriesModel?
    var feedCategoryEpisodesModel: FeedCategoryEpisodesModel?
    var feedCategorySeriesDetailModel: FeedCategorySeriesDetailModel?
    var seriesEpisodeDetailModel: SeriesEpisodeDetailModel?
    @Published var seriesEpisodesCommentsModel: SeriesEpisodesCommentsModel?
    var seriesEpisodesCommentsDetailModel: SeriesEpisodesCommentsDetailModel?
    var seriesEpisodesModel: SeriesEpisodesModel?
    var feedSearchModel: FeedSearchModel?
    var watchlaterSeriesModel: WatchLaterSeriesModel? = nil
    var watchLaterEpisodesModel: WatchLaterEpisodesModel? = nil
    
    var userDetailModel: UserDetailModel?
    
}

extension FeedViewModel: FeedDataProvider {
    // MARK: - Getting feed's data functions
    func getFeedBanners() {
        showLoader = true
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedBanner, type: FeedBannerModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("success")
//                        self?.showLoader = false
                    }
                }
            } receiveValue: { FeedBannerModelData in
                self.feedBannerModel = FeedBannerModelData
            }
            .store(in: &subscriptions)
    }
    
    func getFeedCategories() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategoriesGroup, type: FeedCategoriesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Categories Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { FeedCategoriesModelData in
                self.feedCategoriesModel = FeedCategoriesModelData
            }
            .store(in: &subscriptions)
    }
    
    func getFeedCategorySeries(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategorySeries + id, type: FeedCategorySeriesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Categories Series Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { categorySeriesData in
                self.feedCategorySeriesModel = categorySeriesData
            }
            .store(in: &subscriptions)
    }
    
    func getCategoryEpisodes(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategoryEpisodes + id, type: FeedCategoryEpisodesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Categories Episodes Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { categoryEpisodesData in
                self.feedCategoryEpisodesModel = categoryEpisodesData
            }
            .store(in: &subscriptions)
    }
    
    func getFeedCategorySeriesDetail(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategorySeriesDetail + id, type: FeedCategorySeriesDetailModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Categories Episodes Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { categorySeriesDatailData in
                self.feedCategorySeriesDetailModel = categorySeriesDatailData
            }
            .store(in: &subscriptions)
    }
    
    func getFeedSeriesEpisodes(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodes + id, type: SeriesEpisodesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Categories Episodes Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { seriesEpisodesData in
                self.seriesEpisodesModel = seriesEpisodesData
            }
            .store(in: &subscriptions)
    }
    
    func getSeriesEpisodeDetail(id: String, completion: @escaping (URL?) -> Void) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodeDetail + id + "/", type: SeriesEpisodeDetailModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print("Series Episode Detail Faliure -->", error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Series Episode Detail Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { seriesEpisodeDetailData in
                //                print("Series Episode Detail Data -->", seriesEpisodeDetailData)
                self.seriesEpisodeDetailModel = seriesEpisodeDetailData
                if let url = URL(string: seriesEpisodeDetailData.bvideo.hls_video_playlist_url ?? "") {
                    completion(url)
                } else {
                    completion(nil)
                }
            }
            .store(in: &subscriptions)
    }
    
    func getSeriesEpisodesComments(id: String, commentOrderBy: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodesComments + id + "/?order_by=\(commentOrderBy)", type: SeriesEpisodesCommentsModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print("Series Episode Comments Faliure", error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Series Episode Comments Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { SeriesEpisodesCommentsData in
                self.seriesEpisodesCommentsModel = SeriesEpisodesCommentsData
            }
            .store(in: &subscriptions)
    }
    
    func getSeriesEpisodesCommentsDetail(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodesCommentsDetail + id + "/", type: SeriesEpisodesCommentsDetailModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Series Episode Comments Detail Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { SeriesEpisodesCommentsDetailModel in
                self.seriesEpisodesCommentsDetailModel = SeriesEpisodesCommentsDetailModel
            }
            .store(in: &subscriptions)
    }
    
    func getFeedSearchList(searchParam: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedSearch + searchParam, type: FeedSearchModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showLoader = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Feed Search Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { FeedSearchData in
                self.feedSearchModel = FeedSearchData
            }
            .store(in: &subscriptions)
    }
    
    func getUserDetail() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.userDetails, type: UserDetailModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("User detail success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { userDetailModel in
//                print(String(describing: userDetailModel))
                self.userDetailModel = userDetailModel
            }
            .store(in: &subscriptions)
    }
    
    func createComment(episode: String, comment: String) {
        SeriesEpisodesCreateCommentsAPIService.shared.createCommnet(episode: episode, comment: comment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.commentCreated = true
                    self?.showButtonLoader = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func deleteComment(commentUid: String) {
        SeriesEpisodesDeleteCommentsAPIService.shared.deleteComment(commentUid: commentUid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.commentDeleted = true
                    self?.showButtonLoader = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func editComment(commentUid: String, comment: String) {
        SeriesEpisodesEditCommentsAPIService.shared.editComment(commentUid: commentUid, comment: comment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.commentEdited = true
                    self?.showButtonLoader = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func createReplies(episode: String, parent: String, replyTo: String, comment: String) {
        SeriesEpisodesCreateCommentsAPIService.shared.createReply(episode: episode, parent: parent, replyTo: replyTo, comment: comment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.commentCreated = true
                    self?.showButtonLoader = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func addSeriesWatchLater(seriesUid: String) {
        AddSeriesWatchLaterAPIService.shared.addSeriesWatchLater(seriesUid: seriesUid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showButtonLoader = false
                    self?.watchListAdded = true
                    self?.watchListSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func removeSeriesWatchLater(seriesUid: String) {
        AddSeriesWatchLaterAPIService.shared.removeSeriesWatchLater(seriesUid: seriesUid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showButtonLoader = false
                    self?.watchListAdded = false
                    self?.watchListRemovedSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func addEpisodeWatchLater(episodeUid: String) {
        AddEpisodeWatchLaterAPIService.shared.addEpisodeWatchLater(episodeUid: episodeUid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showButtonLoader = false
                    self?.watchListAdded = true
                    self?.watchListSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func removeEpisodeWatchLater(episodeUid: String) {
        AddEpisodeWatchLaterAPIService.shared.removeEpisodeWatchLater(episodeUid: episodeUid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showButtonLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showButtonLoader = false
                    self?.watchListAdded = false
                    self?.watchListRemovedSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func likeCommnet(comment: String) {
        SeriesEpisodeLikeCommentsAPIService.shared.likeComment(comment: comment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                    }
                case .finished:
                    print("success")
                    self?.likeCommentAdded = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func deleteLikeComment(comment: String) {
        SeriesEpisodeLikeCommentsAPIService.shared.DeleteLikeComment(comment: comment)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                    }
                case .finished:
                    print("success")
                    self?.likeCommentAdded = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func getWatchLaterSeries() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.watchlaterSeries, type: WatchLaterSeriesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("watch later series Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { watchLaterSeriesData in
                self.watchlaterSeriesModel = watchLaterSeriesData
            }
            .store(in: &subscriptions)
    }
    
    func getWatchLaterEpisodes(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.watchLaterEpisodes + "?series_uid=" + id, type: WatchLaterEpisodesModel.self)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("watch later series Success")
//                        self?.showLoader = false
                    }
                }
            } receiveValue: { watchLaterEpisodesData in
                self.watchLaterEpisodesModel = watchLaterEpisodesData
            }
            .store(in: &subscriptions)
    }
}
