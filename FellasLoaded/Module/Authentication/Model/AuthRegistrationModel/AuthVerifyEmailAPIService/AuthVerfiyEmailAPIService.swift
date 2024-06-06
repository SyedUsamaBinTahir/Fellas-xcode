//
//  AuthVerfiyEmailAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 29/05/2024.
//

import Foundation
import Combine

class AuthVerfiyEmailAPIService {
    static let shared = AuthVerfiyEmailAPIService()
    
    func registerRequest(email: String, code: String) -> AnyPublisher<Bool, AuthVerifyApiError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.emailVerify) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let verifyEmailRequestData = try JSONEncoder().encode(AuthVerifyEmailRequest(email: email, code_candidate: code))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = verifyEmailRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(FLUserJourney.shared.authToken ?? "N/A")", forHTTPHeaderField: "Authorization")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw AuthVerifyApiError.urlError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        throw AuthVerifyApiError.EncodeError
                    }
                }
                .mapError({ error in
                    if let flApiError = error as? AuthVerifyApiError {
                        return flApiError
                    } else {
                        return AuthVerifyApiError.unknownError
                    }
                })
                .eraseToAnyPublisher()
        } catch {
            print(String(describing: error))
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
