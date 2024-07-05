//
//  FeedCategoryEpisodesModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 10/06/2024.
//

import Foundation

struct FeedCategoryEpisodesModel: Codable {
    let results: [FeedCategoryEpisodesResults]
}

struct FeedCategoryEpisodesResults: Codable {
    let uid: String
    let series_uid: String
    let series_thumbnail: String
    let session_uid: String
    let title: String
    let session_number: Int
    let episode_number: Int
    let description: String
    let thumbnail: String
    let trailer: String?
    let is_published: Bool
    let is_visible: Bool
//    let reached_episode_time:
    let is_fully_watched: Bool
    let comments_count: Int
    let is_watch_later: Bool
    let playable_from: String
    let release_date: String
    let bvideo: SeriesBvideo?
    let created_at: String
}
