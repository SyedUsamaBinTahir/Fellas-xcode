//
//  FeedSearchModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 26/06/2024.
//

import Foundation

struct FeedSearchModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let current, pagesCount, pageSize: Int
    let pageSizeQueryParam, pageQueryParam: String
    let results: [FeedSearchResults]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, current
        case pagesCount = "pages_count"
        case pageSize = "page_size"
        case pageSizeQueryParam = "page_size_query_param"
        case pageQueryParam = "page_query_param"
        case results
    }
}

// MARK: - Result
struct FeedSearchResults: Codable {
    let uid, title, description: String
    let recommendedType: RecommendedType
    let thumbnail: String
    let seriesUid, sessionUid: String?
    let createdAt: String
    let episodeNumber, sessionNumber: Int?
    let bvideo: SeriesBvideo?
    let commentsCount: Int?
    let isWatchLater: Bool
//    let watchLaterAddedAt: JSONNull?
    let horizontalThumbnail: String?
    let totalEpisodes, sessionsCount, episodesCount, watchLaterCount: Int?

    enum CodingKeys: String, CodingKey {
        case uid, title, description, recommendedType, thumbnail
        case seriesUid = "series_uid"
        case sessionUid = "session_uid"
        case createdAt = "created_at"
        case episodeNumber = "episode_number"
        case sessionNumber = "session_number"
        case bvideo
        case commentsCount = "comments_count"
        case isWatchLater = "is_watch_later"
//        case watchLaterAddedAt = "watch_later_added_at"
        case horizontalThumbnail = "horizontal_thumbnail"
        case totalEpisodes = "total_episodes"
        case sessionsCount = "sessions_count"
        case episodesCount = "episodes_count"
        case watchLaterCount = "watch_later_count"
    }
}

enum RecommendedType: String, Codable {
    case episode = "episode"
    case series = "series"
}
