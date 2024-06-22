//
//  FeedViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation
import Combine

protocol FeedDataProvider {
    func getFeedBanners()
    func getFeedCategories()
    func getFeedCategorySeries(id: String)
    func getCategoryEpisodes(id: String)
    func getFeedCategorySeriesDetail(id: String)
    func getSeriesEpisodeDetail(id: String)
    func getSeriesEpisodesComments(id: String, commentOrderBy: String)
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
    
    // Api Models
    var feedBannerModel: FeedBannerModel?
    var feedCategoriesModel: FeedCategoriesModel?
    var feedCategorySeriesModel: FeedCategorySeriesModel?
    var feedCategoryEpisodesModel: FeedCategoryEpisodesModel?
    var feedCategorySeriesDetailModel: FeedCategorySeriesDetailModel?
    var seriesEpisodeDetailModel: SeriesEpisodeDetailModel?
    var seriesEpisodesCommentsModel: SeriesEpisodesCommentsModel?
    
    var userDetailModel: UserDetailModel?
    
}

extension FeedViewModel: FeedDataProvider {
    // MARK: - Getting feed's data functions
    func getFeedBanners() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedBanner, type: FeedBannerModel.self)
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
                        self?.showLoader = false
                    }
                }
            } receiveValue: { FeedBannerModelData in
                self.feedBannerModel = FeedBannerModelData
            }
            .store(in: &subscriptions)
    }
    
    func getFeedCategories() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategoriesGroup, type: FeedCategoriesModel.self)
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
    
    func getSeriesEpisodeDetail(id: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodeDetail + id, type: SeriesEpisodeDetailModel.self)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("Series Episode Detail Success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { seriesEpisodeDetailData in
//                print("Series Episode Detail Data -->", String(describing: seriesEpisodeDetailData))
                self.seriesEpisodeDetailModel = seriesEpisodeDetailData
            }
            .store(in: &subscriptions)
    }
    
    func getSeriesEpisodesComments(id: String, commentOrderBy: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.seriesEpisodesComments + id + "/?order_by=\(commentOrderBy)", type: SeriesEpisodesCommentsModel.self)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
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
    
    func getUserDetail() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.userDetails, type: UserDetailModel.self)
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
    
}
