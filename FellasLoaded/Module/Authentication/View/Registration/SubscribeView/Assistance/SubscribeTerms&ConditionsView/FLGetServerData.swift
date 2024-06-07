//
//  FLGetServerDataModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 03/06/2024.
//

import Foundation
import Combine

class GetServerData {
    static let shared = GetServerData()
    
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
    
    
    
    
    
    
    //    private init() {
    //
    //    }
    //
    //    private var cancellables = Set<AnyCancellable>()
    //    private let baseURL = "https://api.fellasloaded.com"
    //
    //    func getServerData<T: Decodable>(endpoint: String, id: Int? = nil, type: T.Type) -> Future<[T], Error> {
    //        return Future<[T], Error> { [weak self] promise in
    //            guard let self = self, let url = URL(string: FLAPIs.baseURL + endpoint) else {
    //                return promise(.failure(NetworkError.invalidURL))
    //            }
    //            print("URL is \(url.absoluteString)")
    //            URLSession.shared.dataTaskPublisher(for: url)
    //                .tryMap { (data, response) -> Data in
    //                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
    //                        throw NetworkError.responseError
    //                    }
    //                    return data
    //                }
    //                .decode(type: [T].self, decoder: JSONDecoder())
    //                .receive(on: RunLoop.main)
    //                .sink(receiveCompletion: { (completion) in
    //                    if case let .failure(error) = completion {
    //                        switch error {
    //                        case let decodingError as DecodingError:
    //                            promise(.failure(decodingError))
    //                        case let apiError as NetworkError:
    //                            promise(.failure(apiError))
    //                        default:
    //                            promise(.failure(NetworkError.unknown))
    //                        }
    //                    }
    //                }, receiveValue: { promise(.success($0)) })
    //                .store(in: &self.cancellables)
    //        }
    //    }
}


//enum NetworkError: Error {
//    case invalidURL
//    case responseError
//    case unknown
//    case networkError
//}
//
//extension NetworkError: LocalizedError {
//    var errorDescription: String? {
//        switch self {
//        case .invalidURL:
//            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
//        case .responseError:
//            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
//        case .unknown:
//            return NSLocalizedString("Unknown error", comment: "Unknown error")
//        case .networkError:
//            return NSLocalizedString("Network error", comment: "No Internet Connection")
//        }
//    }
//}

//class GetPaymentPricesAPIService {
//    static let shared = GetPaymentPricesAPIService()
//
//}
//
//extension GetPaymentPricesAPIService {
//    func getPaymentsPrices()  -> AnyPublisher<[GetStripePaymentsModel], NetworkError> {
//        guard let url = URL(string: "https://api.fellasloaded.com/api/subscription/store-subscriptions/?platform=ios") else {
//            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "content-type")
//
//        return URLSession.shared.dataTaskPublisher(for: request)
//            .tryMap { result -> Data in
//                guard let httpResponse = result.response as? HTTPURLResponse else {
//                    throw NetworkError.networkError
//                }
//                if  (200...299).contains(httpResponse.statusCode) {
////                    return settingAPIJson.data(using: .utf8)!
//                    return result.data
//                } else {
//                    throw NetworkError.responseError
//                }
//            }
//            .decode(type: [GetStripePaymentsModel].self, decoder: JSONDecoder())
//            .mapError({ error in
//                if let flGetPaymentError = error as? NetworkError {
//                    return flGetPaymentError
//                } else {
//                    return NetworkError.unknown
//                }
//            })
//            .eraseToAnyPublisher()
//    }
//}
