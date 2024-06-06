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
    
    func registerRequest(email: String, password: String) -> AnyPublisher<AuthRegistrationModel, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.registration) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let loginRequestData = try JSONEncoder().encode(AuthRegistrationRequest(email: email, password: password))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = loginRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Data in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        let resultData = try JSONDecoder().decode(AuthRegistrationModel.self, from: result.data)
                        FLUserJourney.shared.authToken = resultData.access
                        print("saved Registration Token -->", FLUserJourney.shared.authToken ?? "N/A")
                        print("Registration Access Token -->", resultData.access)
                        return result.data
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        throw AuthRegistrationAPIError.EncodeError
                    }
                }
                .decode(type: AuthRegistrationModel.self, decoder: JSONDecoder())
                .mapError({ error in
                    if let flApiError = error as? AuthRegistrationAPIError {
                        return flApiError
                    } else {
                        return AuthRegistrationAPIError.unknownError
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
