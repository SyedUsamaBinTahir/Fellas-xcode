//
//  AuthRegistraionAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation
import Combine

class AuthRegistraionAPIService {
    static let shared = AuthRegistraionAPIService()
    
    func registerRequest(email: String, password: String) -> AnyPublisher<Bool, FLAPIError> {
        guard let url = URL(string: "https://api.fellasloaded.com/api/user/registration/email/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let loginRequestData = try JSONEncoder().encode(AuthRegistrationRequest(email: email, password: password))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = loginRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw FLAPIError.networkError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        throw FLAPIError.networkError
                    }
                }
                .mapError({ error in
                    if let flApiError = error as? FLAPIError {
                        return flApiError
                    } else {
                        return FLAPIError.unknownError
                    }
                })
                .eraseToAnyPublisher()
        } catch {
            print(String(describing: error))
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
