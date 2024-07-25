//
//  FeedBannerModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation

struct FeedBannerModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let current: Int
    let results: [FeedBannerResults]
}

struct FeedBannerResults: Codable, Identifiable {
    let uid: String
    let object_uid: String
    let title: String
    let order: Int
    let banner_type: String
    let cover_art: String?
    let web_desktop_cover_art: String
    let created_at: String
    var id: String { uid }
}
