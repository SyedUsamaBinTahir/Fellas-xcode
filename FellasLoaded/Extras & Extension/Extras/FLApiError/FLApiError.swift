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
            return "Something went wrong. Please try again."
        case .urlError:
            return "Worker template URL error."
        case .networkError:
            return "Network Error."
        case .EncodeError:
            return "Template encode error."
        }
    }
}
