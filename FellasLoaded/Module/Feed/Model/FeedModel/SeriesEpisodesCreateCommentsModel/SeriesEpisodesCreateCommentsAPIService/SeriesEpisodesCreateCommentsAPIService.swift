//
//  SeriesEpisodesCreateCommentsAPIService.swift
//  FellasLoaded
//
//  Created by Syed Usama on 04/07/2024.
//

import Foundation
import Combine

class SeriesEpisodesCreateCommentsAPIService {
    static let shared = SeriesEpisodesCreateCommentsAPIService()
    var cancellable: AnyCancellable?
    
    func createCommnet(episode: String, comment: String) -> AnyPublisher<Bool, SeriesEpisodesCreateCommentsAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.seriesEpisodesCreateComments) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let seriesEpisodesCreateCommentRequest = try JSONEncoder().encode(SeriesEpisodesCreateCommentsRequest(episode: episode, comment: comment))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = seriesEpisodesCreateCommentRequest
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("Params -->", String(data: seriesEpisodesCreateCommentRequest, encoding: .utf8) )
            
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
    
    func createReply(episode: String, parent: String, replyTo: String, comment: String) -> AnyPublisher<Bool, SeriesEpisodesCreateCommentsAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.seriesEpisodesCreateComments) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let seriesEpisodesCreateReplyRequest = try JSONEncoder().encode(SeriesEpisodesCreateRepliesRequest(episode: episode, parent: parent, reply_to: replyTo, comment: comment))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = seriesEpisodesCreateReplyRequest
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("Params -->", String(data: seriesEpisodesCreateReplyRequest, encoding: .utf8) ?? "N/A" )
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { resutl -> Bool in
                    guard let httpResponse = resutl.response as? HTTPURLResponse else {
                        throw SeriesEpisodesCreateCommentsAPIError.urlError
                    }
                    
                    print(String(data: resutl.data, encoding: .utf8) ?? "N/A")
                    
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
