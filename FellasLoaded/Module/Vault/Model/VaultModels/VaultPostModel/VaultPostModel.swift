//
//  VaultPostModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 04/07/2024.
//

import Foundation

struct VaultPostModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let current, pagesCount, pageSize: Int
    let pageSizeQueryParam, pageQueryParam: String
    let results: [VaultPostResult]

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
struct VaultPostResult: Codable {
    let uid, text: String
    let mediaList: [MediaListDetails]
    let commentCounts: Int
    let topComment: TopComment
    var likeCounts: Int
    let isLiked: Bool
    let releaseDate: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case uid, text, mediaList, commentCounts, topComment, likeCounts, isLiked, releaseDate
        case createdAt = "created_at"
    }
}

// MARK: - MediaList
struct MediaListDetails: Codable {
    let uid: String
    let image: String
    let video: String?
}

// MARK: - TopComment
struct TopComment: Codable {
    let uid: String
    let parentUid: String?
    let parentUserName: String?
    let comment: String
    let user: Users
    let replyTo: String?
    let likeCount: Int
    let likedByMe, isPinned: Bool
    let pinnedBy: String?
    let isMine: Bool
    let repliesCount, reportsCount: Int
    let createdAt: String
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case uid
        case parentUid = "parent_uid"
        case parentUserName = "parent_user_name"
        case comment, user
        case replyTo = "reply_to"
        case likeCount = "like_count"
        case likedByMe = "liked_by_me"
        case isPinned = "is_pinned"
        case pinnedBy = "pinned_by"
        case isMine = "is_mine"
        case repliesCount = "replies_count"
        case reportsCount = "reports_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - User
struct Users: Codable {
    let uid, name, email: String
    let phone: String?
    let avatar: String?
    let streak: Streaks?
}

// MARK: - Streak
struct Streaks: Codable {
    let uid: String
    let title: Title
    let crownType: CrownType
    let isActive: Bool
    let totalMonths: Int
    let isAchieved: Bool
    let image: String

    enum CodingKeys: String, CodingKey {
        case uid, title
        case crownType = "crown_type"
        case isActive = "is_active"
        case totalMonths = "total_months"
        case isAchieved = "is_achieved"
        case image
    }
}

enum CrownType: String, Codable {
    case bronze = "BRONZE"
    case gold = "GOLD"
    case red = "RED"
    case silver = "SILVER"
}

enum Title: String, Codable {
    case the12_Months = "12_MONTHS"
    case the1_Month = "1_MONTH"
    case the2_Months = "2_MONTHS"
    case the3_Months = "3_MONTHS"
}





//struct VaultPostModel: Codable {
//    let count: Int
//    let next: String
//    let previous: String?
//    let current: Int
//    let page_count: Int
//    let page_size_query_param: String
//    let page_query_param: String
//    let result: [PostDetails]
//    
//    struct PostDetails: Codable {
//        let uid: String
//        let text: String
//        let mediaList: [MediaListDetails]
//        let commentCounts: Int
//        let topComments: String
//        let likeCOunts: Int
//        let isLike:  Bool
//        let releaseDate: String
//        let created_at: String
//        
//        
//        struct MediaListDetails: Codable {
//            let uid: String
//            let image: String?
//            let video: String?
//        }
//        
//    }
//}
