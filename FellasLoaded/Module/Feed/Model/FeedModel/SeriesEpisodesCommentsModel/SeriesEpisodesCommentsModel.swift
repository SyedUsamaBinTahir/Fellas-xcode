//
//  SeriesEpisodesCommentsModel.swift
//  FellasLoaded
//
//  Created by MAC on 20/06/2024.
//

import Foundation

struct SeriesEpisodesCommentsModel: Codable {
    let count: Int
    var results: [SeriesEpisodesCommentsResults]
}

struct SeriesEpisodesCommentsResults: Codable, Equatable {
    let uid: String
    let parent_user_name: String?
    let user: User?
    let reply_to: ReplyTo?
    let is_pinned: Bool
    let pinned_by: String?
    let is_mine: Bool
    var liked_by_me: Bool
    let comment: String
    let replies_count: Int
    let like_count: Int
    let reports_count: Int
    
    static func == (lhs: SeriesEpisodesCommentsResults, rhs: SeriesEpisodesCommentsResults) -> Bool {
        return lhs.uid == rhs.uid && lhs.liked_by_me == rhs.liked_by_me && lhs.like_count == rhs.like_count
    }
}

struct User: Codable {
    let uid: String
    let name: String?
    let phone: String?
    let avatar: String?
    let streak: UserStreak?
}

struct UserStreak: Codable {
    let uid: String
    let title: String?
    let crown_type: String?
    let is_active: Bool?
    let total_months: Int?
    let is_achieved: Bool?
    let image: String?
}

struct ReplyTo: Codable {
    let uid: String
    let username: String
}
