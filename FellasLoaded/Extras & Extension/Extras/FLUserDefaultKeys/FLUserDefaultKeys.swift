//
//  FLUserDefaultKeys.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

public enum FLUserDefaultKeys: String, CaseIterable {
    case subscribedUserloggedIn = "FLSubscribedUser"
    case unSubscribedUserLoggedIn = "FLunSubscribedUser"
    case accesstoken = "AuthAccessToken"
    case refreshToken = "refreshToken"
    case registrationToken = "AuthRegistrationToken"
}
