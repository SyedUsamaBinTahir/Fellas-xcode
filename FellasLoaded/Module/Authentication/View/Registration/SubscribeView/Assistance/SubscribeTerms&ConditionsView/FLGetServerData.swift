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
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzIwMTY5NDAxLCJpYXQiOjE3MTc1Nzc0MDEsImp0aSI6ImI2MDRlNDc1ZmQ5ZDQyNGY4YjI2NjQ5ZGU2Y2UzMTlhIiwidXNlcl9pZCI6MzU3MzZ9.2m2MJPnLMDOkF5Xi-OORd2-hgKB7_a20clNEk6nZjlM", forHTTPHeaderField: "Authorization")
        
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
