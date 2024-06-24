//
//  SeriesEpisodesCommentsDetailModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 24/06/2024.
//

import Foundation

struct SeriesEpisodesCommentsDetailModel: Codable {
    let parent: SeriesEpisodesCommentsResults
    let replies: [SeriesEpisodesCommentsResults]
}
