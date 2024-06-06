//
//  AuthLoginAPIError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 04/06/2024.
//

import Foundation

public enum AuthLoginAPIError: Error, Equatable {
    case unknownError // 401
    case urlError
    case networkError
    case EncodeError // 400
}

extension AuthLoginAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Somthing went wrong please try again", comment: "Unknown Error")
        case .urlError:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .networkError:
            return NSLocalizedString("No Internet Connection", comment: "No Internet Connection")
        case .EncodeError:
            return NSLocalizedString("Invalid email or password", comment: "Encode Error")
        }
    }
}
