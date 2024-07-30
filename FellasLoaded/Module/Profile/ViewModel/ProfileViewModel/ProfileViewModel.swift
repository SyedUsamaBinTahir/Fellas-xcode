//
//  ProfileViewModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 30/07/2024.
//

import Foundation
import Combine

protocol ProfileDataProvider {
    func getWatchLaterSeries()
    func getWatchLaterEpisodes(id: String)
}

class ProfileViewModel: ObservableObject {
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
    var watchlaterSeriesModel: WatchLaterSeriesModel? = nil
    var watchLaterEpisodesModel: WatchLaterEpisodesModel? = nil
}

extension ProfileViewModel: ProfileDataProvider {
    func getWatchLaterSeries() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.watchlaterSeries, type: WatchLaterSeriesModel.self)
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
        
    }
    
    
}
