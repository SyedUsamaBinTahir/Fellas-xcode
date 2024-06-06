//
//  AuthVerifyEmailAPIError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 04/06/2024.
//

import Foundation

public enum AuthVerifyApiError: Error, Equatable {
    case unknownError
    case urlError
    case networkError
    case EncodeError
}

extension AuthVerifyApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Unkonwn Error", comment: "Somthing went wrong please try again")
        case .urlError:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .networkError:
            return NSLocalizedString("No Internet Connection", comment: "No Internet Connection")
        case .EncodeError:
            return NSLocalizedString("Wrong Code", comment: "Encoding Error")
        }
    }
}
