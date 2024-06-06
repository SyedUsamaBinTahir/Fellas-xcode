//
//  ForgotPasswordAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 30/05/2024.
//

import Foundation
import Combine

class ForgotPasswordAPIService {
    static let shared = ForgotPasswordAPIService()
    
    func requestForgotPasswordCode(email: String) -> AnyPublisher<Bool, ForgotPasswordAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.forgotPassword) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let forgotPassswordRequestData = try JSONEncoder().encode(ForgotPasswordRequest(email: email))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = forgotPassswordRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { resutl -> Bool in
                    guard let httpResponse = resutl.response as? HTTPURLResponse else {
                        throw ForgotPasswordAPIError.urlError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
                        throw ForgotPasswordAPIError.EncodeError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? ForgotPasswordAPIError {
                        return flApiError
                    } else {
                        return ForgotPasswordAPIError.unknownError
                    }
                }.eraseToAnyPublisher()
        } catch {
            print(error)
            if let error = error as? EncodingError {
                switch error {
                case .invalidValue(_, _):
                    return Fail(error: .EncodeError).eraseToAnyPublisher()
                default:
                    return Fail(error: .EncodeError).eraseToAnyPublisher()
                }
            } else {
                return Fail(error: .unknownError).eraseToAnyPublisher()
            }
        }
    }
}
