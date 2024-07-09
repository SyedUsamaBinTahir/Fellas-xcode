//
//  SeriesEpisodeLikeCommentsAPIService.swift
//  FellasLoaded
//
//  Created by Syed Usama on 09/07/2024.
//

import Foundation
import Combine

class SeriesEpisodeLikeCommentsAPIService {
    static let shared = SeriesEpisodeLikeCommentsAPIService()
    var cancellable: AnyCancellable?

    func likeComment(comment: String) -> AnyPublisher<Bool, SeriesEpisodesCreateCommentsAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.seriesEpisodesLikeComments) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let seriesEpisodesLikeCommentRequest = try JSONEncoder().encode(SeriesEpisodeLikeCommentsAPIRequest(comment: comment))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = seriesEpisodesLikeCommentRequest
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("Params -->", String(data: seriesEpisodesLikeCommentRequest, encoding: .utf8) )
            
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
    
    func DeleteLikeComment(comment: String)  -> AnyPublisher<Bool, AddSeriesWatchLaterAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.seriesEpisodesDeleteLikeComments + comment + "/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            
            print("\(request.httpMethod!) \(request.url!)")
            print(request.allHTTPHeaderFields!)
            print(String(data: request.httpBody ?? Data(), encoding: .utf8)!)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { resutl -> Bool in
                    guard let httpResponse = resutl.response as? HTTPURLResponse else {
                        throw AddSeriesWatchLaterAPIError.urlError
                    }
                    
//                    print(String(data: resutl.data, encoding: .utf8) ?? "")
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
                        throw AddSeriesWatchLaterAPIError.EncodeError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? AddSeriesWatchLaterAPIError {
                        return flApiError
                    } else {
                        return AddSeriesWatchLaterAPIError.unknownError
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
            }
            else {
                return Fail(error: .unknownError).eraseToAnyPublisher()
            }
        }
    }
}
