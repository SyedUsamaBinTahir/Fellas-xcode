//
//  SeriesEpisodesEditCommentsAPIService.swift
//  FellasLoaded
//
//  Created by Syed Usama on 25/07/2024.
//

import Foundation
import Combine

class SeriesEpisodesEditCommentsAPIService {
    static let shared = SeriesEpisodesEditCommentsAPIService()
    var cancellable: AnyCancellable?
    
    func editComment(commentUid: String, comment: String) -> AnyPublisher<Bool, SeriesEpisodesCreateCommentsAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.seriesEpisodesEditComments + commentUid + "/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let seriesEpisodesEditCommentRequest = try JSONEncoder().encode(SeriesEpisodesEditCommentsRequest(comment: comment))
            
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.httpBody = seriesEpisodesEditCommentRequest
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("Params -->", String(data: seriesEpisodesEditCommentRequest, encoding: .utf8) )
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { resutl -> Bool in
                    guard let httpResponse = resutl.response as? HTTPURLResponse else {
                        throw SeriesEpisodesCreateCommentsAPIError.urlError
                    }
                    
                    print(String(data: resutl.data, encoding: .utf8))
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
                        throw SeriesEpisodesCreateCommentsAPIError.EncodeError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? SeriesEpisodesCreateCommentsAPIError {
                        return flApiError
                    } else {
                        return SeriesEpisodesCreateCommentsAPIError.unknownError
                    }
                }.eraseToAnyPublisher()
        } catch {
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
