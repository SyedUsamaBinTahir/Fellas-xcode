//
//  FLApiError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

public enum FLAPIError: Error, Equatable {
    case unknownError
    case urlError
    case networkError
    case EncodeError
}

extension FLAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Somthing went wrong please try again", comment: "Unknown Error")
        case .urlError:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .networkError:
            return NSLocalizedString("No Internet Connection", comment: "No Internet Connection")
        case .EncodeError:
            return NSLocalizedString("Un unknown error accoured", comment: "Encoding Error")
        }
    }
}
