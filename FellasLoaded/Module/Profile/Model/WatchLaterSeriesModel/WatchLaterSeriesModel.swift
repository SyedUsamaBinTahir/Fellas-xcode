//
//  WatchLaterSeriesModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 30/07/2024.
//

import Foundation

struct WatchLaterSeriesModel: Codable {
    let order: Int
    let count: Int
    let results: [FeedCategorySeriesDetailModel]?
}
