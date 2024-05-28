//
//  FLAuthTextFieldError.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation

public enum IHAuthTextFieldError: Error, Equatable {
    case invalidEmail(String)
    case invalidPassword(String)
    case invalidConfirmPassword(String)
    case invalidConfirmEmail(String)
    case invalidName(String)
}

extension IHAuthTextFieldError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail(let errorMsg):
            return errorMsg
        case .invalidPassword(let errorMsg):
            return errorMsg
        case .invalidConfirmPassword(let errorMsg):
            return errorMsg
        case .invalidConfirmEmail(let errorMsg):
            return errorMsg
        case .invalidName(let errorMsg):
            return errorMsg
        }
    }
}
