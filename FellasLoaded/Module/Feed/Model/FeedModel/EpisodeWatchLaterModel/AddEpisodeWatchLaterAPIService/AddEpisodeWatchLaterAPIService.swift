//
//  AddEpisodeWatchLaterAPIService.swift
//  FellasLoaded
//
//  Created by Syed Usama on 09/07/2024.
//

import Foundation

import Combine

class AddEpisodeWatchLaterAPIService {
    static let shared = AddEpisodeWatchLaterAPIService()
    var cancellable: AnyCancellable?
    
    func addEpisodeWatchLater(episodeUid: String) -> AnyPublisher<Bool, AddSeriesWatchLaterAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.addWatchLater) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let addEpisodeWatchLaterAPIRequest = try JSONEncoder().encode(AddEpisodeWatchLaterAPIRequest(episode_uid: episodeUid))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = addEpisodeWatchLaterAPIRequest
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
    
    func removeEpisodeWatchLater(episodeUid: String) -> AnyPublisher<Bool, AddSeriesWatchLaterAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.removeWatchLater + episodeUid + "/") else {
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
