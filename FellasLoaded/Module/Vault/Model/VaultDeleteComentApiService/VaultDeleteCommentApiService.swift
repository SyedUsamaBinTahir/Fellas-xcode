//
//  VaultDeleteCommentApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 25/07/2024.
//

import Foundation
import Combine

class VaultDeleteCommentApiService {
    static let shared = VaultDeleteCommentApiService()
    var cancellable: AnyCancellable?
    
    func vaultDeleteComment(commentId: String) -> AnyPublisher<Bool, AuthRegistrationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.vaultDeleteComent + commentId + "/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            
            let deleteComment = try JSONEncoder().encode(VaultDeleteCommentModel(comment_uid: commentId))
            
            var request  = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.httpBody = deleteComment
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("COMMENT DELETE PARAMS --->", String(data: deleteComment, encoding: .utf8))
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap{result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
                        throw AuthRegistrationAPIError.EncodeError
                    }
                } .mapError({ error in
                    if let flAPiError = error as? AuthRegistrationAPIError {
                        return flAPiError
                    } else {
                        return AuthRegistrationAPIError.unknownError
                    }
                })
                .eraseToAnyPublisher()
            
            
        } catch {
            print(String(describing: error))
            
            if let error = error  as? EncodingError {
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
