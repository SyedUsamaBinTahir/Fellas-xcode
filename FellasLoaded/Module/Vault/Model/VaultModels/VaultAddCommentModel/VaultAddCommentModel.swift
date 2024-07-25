//
//  VaultAddCommentModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 09/07/2024.
//

import Foundation

struct VaultAddCommentModel: Codable {
    let comment: String
    let post: String
//    let parent_uid: String
//    let reply_to: String
}

struct VaultReplyCommentModel: Codable {
    let comment: String
    let post: String
    let parent: String
    let reply_to: String
}
