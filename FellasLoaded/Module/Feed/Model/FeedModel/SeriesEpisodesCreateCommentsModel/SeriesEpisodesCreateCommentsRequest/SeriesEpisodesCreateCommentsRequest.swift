//
//  SeriesEpisodesCreateCommentsModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 04/07/2024.
//

import Foundation

struct SeriesEpisodesCreateCommentsRequest: Codable {
    let episode: String
//    let parent: String
//    let reply_to: String
    let comment: String
}
