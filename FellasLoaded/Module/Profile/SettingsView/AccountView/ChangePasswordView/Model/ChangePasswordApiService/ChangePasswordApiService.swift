//
//  ChangePasswordApiService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 12/07/2024.
//

import Foundation
import Combine

class ChangePasswordApiService {
    static let shared = ChangePasswordApiService()
    var cancellable: AnyCancellable?
    
    func  changePassword(oldPassword: String, newPassword: String) -> AnyPublisher<Bool, AuthRegistrationAPIError>{
        
        guard let url = URL(string : FLAPIs.baseURL + FLAPIs.changePassword) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }
        
        do {
            let changePassword = try JSONEncoder().encode(ChangePasswordModel(old_password: oldPassword, new_password: newPassword))
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = changePassword
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
            print("PARAMS", String(data: changePassword, encoding: .utf8))
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpsResponse = result.response as? HTTPURLResponse else {
                        throw AuthRegistrationAPIError.networkError
                    }
                    
                    if (200...299).contains(httpsResponse.statusCode) {
                        return true
                    } else {
                        throw AuthRegistrationAPIError.EncodeError
                    }
                }.mapError({ error in
                    if let flApiError = error as? AuthRegistrationAPIError {
                        return flApiError
                    } else {
                        return AuthRegistrationAPIError.unknownError
                    }
                })
                .eraseToAnyPublisher()
            
        } catch {
            print(String(describing:  error))
            
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
