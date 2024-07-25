//
//  VaultCommentApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 09/07/2024.
//

import Foundation
import Combine

class VaultCommentApiService {
    static let shared = VaultCommentApiService()
    var cancellable: AnyCancellable?
    
    func vaultAddComment(comment: String, post: String) -> AnyPublisher<Bool, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.vaultAddComment) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        do {
            let addComment = try JSONEncoder().encode(VaultAddCommentModel(comment: comment, post: post))
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = addComment
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("PARAMS --->", String(data: addComment, encoding: .utf8))
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool  in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {                                                
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
    
    func vaultCommentReply(comment: String, post: String, parent: String, replyTto: String) -> AnyPublisher<Bool, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.vaultAddComment) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        do {
            let addComment = try JSONEncoder().encode(VaultReplyCommentModel(comment: comment, post: post, parent: parent, reply_to: replyTto))
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = addComment
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("PARAMS --->", String(data: addComment, encoding: .utf8))

            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool  in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                                                
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
