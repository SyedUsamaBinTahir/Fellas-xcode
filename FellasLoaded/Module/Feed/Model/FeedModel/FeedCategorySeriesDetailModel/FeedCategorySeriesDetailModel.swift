//
//  FeedCategorySeriesDetailModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 10/06/2024.
//

import Foundation

struct FeedCategorySeriesDetailModel: Codable {
    let uid: String
    let title: String
    let description: String?
    let cover_art: String?
    let thumbnail: String
    let horizontal_thumbnail: String
    let vertical_cover_photo: String
    let horizontal_cover_photo: String
    let logo: String
    let total_episodes: Int
    let total_sessions: Int
    let sessions_count: Int
    let episodes_count: Int
    let hosts: [FeedCategorySeriesDetailHosts]?
    let genre: FeedCategorySeriesDetailGenre?
    let sessions: [FeedCategorySeriesDetailSessions]?
    let is_watch_later: Bool
    let watch_later_count: Int
    let is_notification_subscribed: Bool
}

struct FeedCategorySeriesDetailHosts: Codable {
    let id: Int
    let uid: String
    let name: String
    let created_at: String
}

struct FeedCategorySeriesDetailGenre: Codable {
    let uid: String
    let name: String
}

struct FeedCategorySeriesDetailSessions: Codable {
    let uid: String
    let title: String
    let description: String
    let cover_art: String?
    let session_number: Int
    let total_episodes: Int
    let episodes_count: Int
    let episodes: [FeedCategoryEpisodesResults]?
}
