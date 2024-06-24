//
//  FLAPIEndpoints.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation

class FLAPIs {
    static let baseURL = "https://api.fellasloaded.com/api"
    static let imageURL = "https://storage.googleapis.com/fellas_media/"
}

extension FLAPIs {
    // Authentication
    static let login = "/user/auth/email/"
    static let registration = "/user/registration/email/"
    static let emailRequest = "/user/email/verify/request/"
    static let emailVerify = "/user/email/verify/submit/"
    static let displayNameAndImage = "/user/update/"
    static let forgotPassword = "/user/password/reset/request/"
    static let codeVerification = "/user/password/reset/check_code/"
    static let newPassword = "/user/password/reset/submit/"
    
    // Feeds
    static let feedBanner = "/feed/banners/"
    static let feedCategoriesGroup = "/feed/categories/group/"
    static let feedCategorySeries = "/feed/categories/series/"
    static let feedCategoryEpisodes = "/feed/categories/episodes/"
    static let feedCategorySeriesDetail = "/series/series/"
    static let seriesEpisodeDetail = "/series/episodes/detail/"
    static let seriesEpisodesComments = "/series/episodes/comments/"
    static let seriesEpisodesCommentsDetail = "/series/episodes/comments/detail/"
    
    // User details
    static let userDetails = "/user/detail/"
}
