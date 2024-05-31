//
//  FLApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation
import Combine

class AuthLoginAPIService {
    static let shared = AuthLoginAPIService()
    var cancellable: AnyCancellable?
    
    func getAccessToken(email: String, password: String) -> AnyPublisher<AuthLoginAPIModel, FLAPIError> {
        guard let url = URL(string: "https://api.fellasloaded.com/api/user/auth/email/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let loginRequestData = try JSONEncoder().encode(AuthLoginRequest(email: email, password: password))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = loginRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Data in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw FLAPIError.networkError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        let resultData = try JSONDecoder().decode(AuthLoginAPIModel.self, from: result.data)
                        FLUserJourney.shared.authToken = resultData.access
                        print("AuthLogin Access Token -->", resultData.access)
                        print("Saved auth login access token -->", FLUserJourney.shared.authToken ?? "N/A")
                        UserDefaults.standard.setValue(FLUserJourney.shared.authToken, forKey: FLUserDefaultKeys.Accesstoken.rawValue)
                        return result.data
                    } else {
                        throw FLAPIError.networkError
                    }
                }
                .decode(type: AuthLoginAPIModel.self, decoder: JSONDecoder())
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
