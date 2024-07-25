//
//  VaultCommentDislikeApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 10/07/2024.
//

import Foundation
import Combine

class VaultCommentDislikeApiService {
    static let shared = VaultCommentDislikeApiService()
    var cancellable: AnyCancellable?
    
    func vaultCommentDislike(commentId: String) -> AnyPublisher<Bool, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.vaultCommentDislike + "\(commentId)/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let commentDislike = try JSONEncoder().encode(VaultCommentLikeModel(comment_uid: commentId))
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.httpBody = commentDislike
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("DELETE PARAMS ---->", String(data: commentDislike, encoding: .utf8))
            
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

