//
//  CheckEmailAPiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 29/05/2024.
//

import Foundation
import Combine

class CheckEmailAPIService {
    static let shared = CheckEmailAPIService()
    
    func registerRequest(email: String) -> AnyPublisher<Bool, CheckEmailApiError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.emailRequest) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let checkEmailRequestData = try JSONEncoder().encode(CheckEmailRequest(email: email))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = checkEmailRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(FLUserJourney.shared.authToken ?? "N/A")", forHTTPHeaderField: "Authorization")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw CheckEmailApiError.urlError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        throw CheckEmailApiError.EncodeError
                    }
                }
                .mapError({ error in
                    if let flApiError = error as? CheckEmailApiError {
                        return flApiError
                    } else {
                        return CheckEmailApiError.unknownError
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
