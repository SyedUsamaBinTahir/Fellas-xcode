//
//  FeedViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
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
    
    // MARK: - Getting feed's data functions
    func getFeedBanners() {
        GetServerData.shared.getServerData(url: FLAPIs.baseURL + FLAPIs.feedBanner, type: FeedBannerModel.self)
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
        GetServerData.shared.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategoriesGroup, type: FeedCategoriesModel.self)
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
        GetServerData.shared.getServerData(url: FLAPIs.baseURL + FLAPIs.feedCategorySeries + id, type: FeedCategorySeriesModel.self)
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
}
