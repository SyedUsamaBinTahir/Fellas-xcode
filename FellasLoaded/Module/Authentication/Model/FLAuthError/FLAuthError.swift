//
//  FLAuthError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation

public enum FLAuthError: Error, Equatable {
    case errorSigningIn
    case errorSigningOut
    case resetPasswordFailure
    case networkError
    case couldNotFetchProfile
    case invalidEmail
    case emailTaken
    case accountDoesNotExist
    case passwordDoesNotMatch
    case passwordTooShort
    case emailInvalid
    case emailDoesNotMatch
    case unknownError
    case getTokenError
    case getSettingError(String = "")
}

extension FLAuthError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .errorSigningIn:
            return "There was an issue signing you in."
        case .errorSigningOut:
            return "There was an issue signing you out."
        case .resetPasswordFailure:
            return "There was an issue resetting your password."
        case .networkError:
            return "Please check your network."
        case .couldNotFetchProfile:
            return "We could not find your profile."
        case .invalidEmail:
            return "Please check your email."
        case .emailTaken:
            return "That email is taken already."
        case .unknownError:
            return "Something went wrong."
        case .accountDoesNotExist:
            return "Account does not exist."
        case .passwordTooShort:
            return "Your password is too short."
        case .emailInvalid:
            return "Your email is invalid."
        case .passwordDoesNotMatch:
            return "Your passwords do not match."
        case .emailDoesNotMatch:
            return "Your emails do not match."
        case .getTokenError:
            return "Token error."
        case .getSettingError(let description):
            return "Get client setting error. \(description)"
        }
    }
}
