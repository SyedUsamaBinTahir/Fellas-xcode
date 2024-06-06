//
//  FLAPIEndpoints.swift
//  FellasLoaded
//
//  Created by Phebsoft on 05/06/2024.
//

import Foundation

class FLAPIs {
    static let baseURL = "https://api.fellasloaded.com/api"
    
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
    static let feedCategories = "/feed/categories/"
}
