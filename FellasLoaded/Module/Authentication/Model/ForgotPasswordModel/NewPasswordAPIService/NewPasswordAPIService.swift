//
//  NewPasswordAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 31/05/2024.
//

import Foundation
import Combine

class NewPasswordAPIService {
    static let shared = NewPasswordAPIService()
    
    func verifyForgotPasswordCode(code: String, password: String) -> AnyPublisher<Bool, FLAPIError> {
        guard let url = URL(string: "https://api.fellasloaded.com/api/user/password/reset/submit/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let newPasswordRequestData = try JSONEncoder().encode(NewPasswordRequestModel(code_candidate: code, password_candidate: password))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = newPasswordRequestData
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            print(String(data: newPasswordRequestData, encoding: .utf8) ?? "N/A")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw FLAPIError.networkError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        print(httpResponse.statusCode)
                        throw FLAPIError.networkError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? FLAPIError {
                        return flApiError
                    } else {
                        return FLAPIError.unknownError
                    }
                }
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
