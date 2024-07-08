//
//  SeriesEpisodesCreateRepliesRequest.swift
//  FellasLoaded
//
//  Created by Syed Usama on 08/07/2024.
//

import Foundation

struct SeriesEpisodesCreateRepliesRequest: Codable {
    let episode: String
    let parent: String
    let reply_to: String
    let comment: String
}
