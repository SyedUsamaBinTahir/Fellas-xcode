//
//  FLAPIEndpoints.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation

class FLAPIs {
    // Production URL
    static let baseURL = "https://api.fellasloaded.com/api"
    // Stagging URL
//    static let baseURL = "https://api.staging.fellas.gitwork.tech/api"
    static let imageURL = "https://storage.googleapis.com/fellas_media/"
}

extension FLAPIs {
    
    // MARK: - Authentication
    static let login = "/user/auth/email/"
    static let registration = "/user/registration/email/"
    static let emailRequest = "/user/email/verify/request/"
    static let emailVerify = "/user/email/verify/submit/"
    static let displayNameAndImage = "/user/update/"
    static let forgotPassword = "/user/password/reset/request/"
    static let codeVerification = "/user/password/reset/check_code/"
    static let newPassword = "/user/password/reset/submit/"
    
    // MARK: - Feeds
    static let feedBanner = "/feed/banners/"
    static let feedCategoriesGroup = "/feed/categories/group/"
    static let feedCategorySeries = "/feed/categories/series/"
    static let feedCategoryEpisodes = "/feed/categories/episodes/"
    static let feedCategorySeriesDetail = "/series/series/"
    static let feedSearch = "/series/search/"
    // Series Endpoints
    static let seriesEpisodeDetail = "/series/episodes/detail/"
    static let seriesEpisodes = "/series/episodes/"
    static let seriesEpisodesComments = "/series/episodes/comments/"
    static let seriesEpisodesCommentsDetail = "/series/episodes/comments/detail/"
    static let seriesEpisodesCreateComments = "/series/episodes/create/comments/"
    static let seriesEpisodesDeleteComments = "/series/episodes/delete/comments/"
    static let seriesEpisodesEditComments = "/series/episodes/update/comments/"
    static let seriesEpisodesLikeComments = "/series/episodes/like/comments/"
    static let seriesEpisodesDeleteLikeComments = "/series/episodes/delete/like/comments/"
    // History Endpoints
    static let addSeriesWatchLater = "/history/add-series-watch-later/"
    static let addWatchLater = "/history/add-watch-later/"
    static let removerSeriesWatchLater = "/history/remove-watch-later-series/"
    static let removeWatchLater = "/history/remove-watch-later/"
    
    //MARK: Vault
      static let vaultPost = "/vault/posts/"
      static let vaultPostLike = "/vault/like/post/"
      static let vaultPostDislike = "/vault/remove/like/post/"
      static let vaultComments = "/vault/post/comments/"
      static let vaultCommentsReply = "/vault/comment/detail/"
      static let vaultAddComment = "/vault/add/comment/"
      static let vaultLikeComment = "/vault/like/comment/"
      static let vaultCommentDislike = "/vault/remove/like/comment/"
      static let vaultDeleteComent = "/vault/remove/comment/"
    static let vaultEditComment = "/vault/edit/comment/"
      // User details
      static let userDetails = "/user/detail/"
      static let editProfile = "/user/update/"
      static let changePassword = "/user/password/change/"
      static let deleteUser = "/user/delete/"
}
