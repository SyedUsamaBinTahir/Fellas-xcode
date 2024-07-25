//
//  VaultPostDislikeApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 10/07/2024.
//

import Foundation
import Combine

class VaultPostDislikeApiService {
    static let shared = VaultPostDislikeApiService()
    var cancellable: AnyCancellable?
    
    func vaultPostDislike(postId: String) -> AnyPublisher<Bool, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.vaultPostDislike + "\(postId)/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let postLike = try JSONEncoder().encode(VaultPostDislikeModel(post_uid: postId))
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.httpBody = postLike
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("DELETE PARAMS ---->", String(data: postLike, encoding: .utf8))
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpsResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    
                    if (200...299).contains(httpsResponse.statusCode) {
                        return true
                    } else {
                        throw AuthRegistrationAPIError.EncodeError
                    }
                    
                }
                .mapError ({ error in
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
                    
                default :
                    return Fail(error: .EncodeError).eraseToAnyPublisher()
                }
            } else {
                return Fail(error: .unknownError).eraseToAnyPublisher()
            }
        }
    }
}
