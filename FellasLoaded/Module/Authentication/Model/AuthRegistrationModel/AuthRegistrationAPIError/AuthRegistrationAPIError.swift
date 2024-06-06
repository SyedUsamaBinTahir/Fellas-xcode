//
//  AuthRegistrationAPIError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 04/06/2024.
//

import Foundation

public enum AuthRegistrationAPIError: Error, Equatable {
    case unknownError
    case urlError
    case networkError
    case EncodeError
}

extension AuthRegistrationAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Somthing went wrong please try again", comment: "Unkonwn Error")
        case .urlError:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .networkError:
            return NSLocalizedString("No Internet Connection", comment: "No Internet Connection")
        case .EncodeError:
            return NSLocalizedString("User already registered", comment: "Encoding Error")
        }
    }
}
