//
//  VaultCommentsModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/07/2024.
//

import Foundation

struct VaultCommentsModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let current: Int
    let pages_count: Int
    let page_size: Int
    let page_size_query_param: String
    let results: [SeriesEpisodesCommentsResults]?
    
    
    struct CommentsDetail: Codable {
        let uid: String
        let parent_uid: String?
        let parent_user_uid: String?
        let comment: String
        let user: VaultCommentUser
        let reply_to: VaultReplyTo?
        let like_count: Int
        let liked_by_me: Bool
        let is_pinned: Bool
        let is_mine: Bool
        let replies_count: Int
        let reports_count: Int
        let created_at: String
        let updated_at: String?
        
        struct VaultCommentUser: Codable {
            let uid: String
            let name: String
            let email: String
            let phone: String?
            let avatar: String
            let streak: VaultCommentStreak
            
            struct VaultCommentStreak: Codable {
                let uid: String
                let title: String
                let crown_type: String
                let is_active: Bool
                let total_months: Int
                let is_achieved: Bool
                let image: String
            }
        }
    }
    struct VaultReplyTo: Codable {
        let uid: String
        let usernameL: String
    }
}

