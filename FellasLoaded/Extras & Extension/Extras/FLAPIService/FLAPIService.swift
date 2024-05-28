//
//  FLApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    
    func postRequest<T: Codable>(url: URL, params: [String: Any], type: T.Type, completionHandler: @escaping (T) -> Void, errorHandler: @escaping (String) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        print("POST: --> \(url.absoluteString)")
        params.printAsJSON()
        
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                errorHandler(error?.localizedDescription ?? "Error!")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                errorHandler("Status code is not 200")
            }
            
            if let mappedResponse = try? JSONDecoder().decode(T.self, from: data) {
                print("Response: <-- \(url.absoluteString)")
                data.printAsJSON()
                completionHandler(mappedResponse)
            }
        }
        
        task.resume()
    }
}

class DataService {
    static let shared = DataService()
    var cancellable: AnyCancellable?
    
    func getAccessToken(email: String, password: String) -> AnyPublisher<AuthLoginModel, FLAPIError> {
        guard let url = URL(string: "https://api.fellasloaded.com/api/user/auth/email/") else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let loginRequestData = try JSONEncoder().encode(AuthLoginRequest(email: email, password: password))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = loginRequestData
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Data in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw FLAPIError.networkError
                    }
                    if (200...299).contains(httpResponse.statusCode) {
                        let resultData = try JSONDecoder().decode(AuthLoginModel.self, from: result.data)
//                        UserDefaults.standard.setValue(resultData.access, forKey: FLUserDefaultKeys.Accesstoken.rawValue)
                        print("Result Data -->",resultData.access)
                        print("result errors", resultData)
                        return result.data
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        throw FLAPIError.networkError
                    }
                }
                .decode(type: AuthLoginModel.self, decoder: JSONDecoder())
                .mapError({ error in
                    if let flApiError = error as? FLAPIError {
                        return flApiError
                    } else {
                        return FLAPIError.unknownError
                    }
                })
                .eraseToAnyPublisher()
        } catch {
            print(String(describing: error))
            if let error = error as? EncodingError {
                switch error {
                case .invalidValue(let any, let context):
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
