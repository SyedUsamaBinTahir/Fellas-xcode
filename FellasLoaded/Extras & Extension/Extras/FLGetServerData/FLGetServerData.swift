//
//  FLGetServerDataModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 03/06/2024.
//

import Foundation
import Combine

protocol DataServiceBased {
    func getServerData<T: Codable>(url: String, type: T.Type) -> AnyPublisher<T, FLAPIError>
}

class GetServerData: DataServiceBased {
    static let shared = GetServerData()
}

extension GetServerData {
    func getServerData<T: Codable>(url: String, type: T.Type) -> AnyPublisher<T, FLAPIError> {
        guard let url = URL(string: url) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
        
        print("\(request.httpMethod!) \(request.url!)")
        print(request.allHTTPHeaderFields!)
        print(String(data: request.httpBody ?? Data(), encoding: .utf8)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw FLAPIError.urlError
                }
                if  (200...299).contains(httpResponse.statusCode) {
                    return result.data
                } else {
                    throw FLAPIError.EncodeError
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error in
                if let flAPIError = error as? FLAPIError {
                    return flAPIError
                } else {
                    print(String(describing: error))
                    return FLAPIError.unknownError
                }
            })
            .eraseToAnyPublisher()
    }
}
