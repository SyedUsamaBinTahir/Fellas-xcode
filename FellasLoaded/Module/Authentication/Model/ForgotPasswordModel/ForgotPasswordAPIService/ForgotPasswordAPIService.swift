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
    
    func requestForgotPasswordCode(email: String) -> AnyPublisher<Bool, FLAPIError> {
        guard let url = URL(string: "https://api.fellasloaded.com/api/user/password/reset/request/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let forgotPassswordRequestData = try JSONEncoder().encode(ForgotPasswordRequest(email: email))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = forgotPassswordRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(FLUserJourney.shared.authRegistrationToken ?? "N/A")", forHTTPHeaderField: "Authorization")
            print(FLUserJourney.shared.authToken ?? "N/A")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { resutl -> Bool in
                    guard let httpResponse = resutl.response as? HTTPURLResponse else {
                        throw FLAPIError.networkError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
                        throw FLAPIError.unknownError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? FLAPIError {
                        return flApiError
                    } else {
                        return FLAPIError.EncodeError
                    }
                }.eraseToAnyPublisher()
        } catch {
            print(error)
            if let error = error as? EncodingError {
                switch error {
                case .invalidValue(let any, let context):
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
