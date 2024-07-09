//
//  AddSeriesWatchLaterAPIError.swift
//  FellasLoaded
//
//  Created by Syed Usama on 09/07/2024.
//

import Foundation

public enum AddSeriesWatchLaterAPIError: Error, Equatable {
    case unknownError // 401
    case urlError
    case networkError
    case EncodeError // 400
}

extension AddSeriesWatchLaterAPIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Somthing went wrong please try again", comment: "Unknown Error")
        case .urlError:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .networkError:
            return NSLocalizedString("No Internet Connection", comment: "No Internet Connection")
        case .EncodeError:
            return NSLocalizedString("Must be a valid UUID", comment: "Encode Error")
        }
    }
}
