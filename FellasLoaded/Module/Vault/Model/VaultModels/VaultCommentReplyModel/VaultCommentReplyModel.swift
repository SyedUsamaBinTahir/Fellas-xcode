//
//  VaultCommentReplyModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 08/07/2024.
//

import Foundation

struct VaultCommentReplyModel: Codable {
    let count: Int
    let results: [VaultReplyDetails]?
}

struct VaultReplyDetails: Codable {
    let uid: String
    let parent_user_name: String?
    let user: VaultReplyUser?
    let reply_to: VaultReplyTo?
    let is_pinned: Bool
    let pinned_by: String?
    let is_mine: Bool
    let liked_by_me: Bool
    let comment: String
    let replies_count: Int
    let like_count: Int
    let reports_count: Int
}

struct VaultReplyUser: Codable {
    let uid: String
    let name: String?
    let phone: String?
    let avatar: String?
    let streak: VaultUserStreak?
}

struct VaultUserStreak: Codable {
    let uid: String
    let title: String?
    let crown_type: String?
    let is_active: Bool?
    let total_months: Int?
    let is_achieved: Bool?
    let image: String?
}

struct VaultReplyTo: Codable {
    let uid: String
    let username: String
}
