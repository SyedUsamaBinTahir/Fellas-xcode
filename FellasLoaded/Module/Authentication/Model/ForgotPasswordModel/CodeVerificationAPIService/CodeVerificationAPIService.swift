//
//  CodeVerificationAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 30/05/2024.
//

import Foundation
import Combine

class CodeVerificationAPIService {
    static let shared = CodeVerificationAPIService()
    
    func verifyForgotPasswordCode(email: String, code: String) -> AnyPublisher<Bool, CodeVerificationAPIError> {
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.codeVerification) else {
            return Fail(error: .urlError).eraseToAnyPublisher()
        }

        do {
            let verifyForgotPasswordCodeData = try JSONEncoder().encode(CodeVerficationRequestModel(email_candidate: email, code_candidate: code))

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = verifyForgotPasswordCodeData
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            print(String(data: verifyForgotPasswordCodeData, encoding: .utf8) ?? "N/A")
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { result -> Bool in
                    guard let httpResponse = result.response as? HTTPURLResponse else {
                        throw CodeVerificationAPIError.urlError
                    }
                    
                    if (200...299).contains(httpResponse.statusCode) {
                        return true
                    } else {
//                        let httpErrorCode = httpResponse.statusCode
                        print(httpResponse.statusCode)
                        throw CodeVerificationAPIError.EncodeError
                    }
                }
                .mapError { error in
                    if let flApiError = error as? CodeVerificationAPIError {
                        return flApiError
                    } else {
                        return CodeVerificationAPIError.unknownError
                    }
                }
                .eraseToAnyPublisher()
        } catch {
            print(String(describing: error))
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

//let parameters = "{\n  \"email_candidate\": \"princedavill007@gmail.com\",\n  \"code_candidate\": \"\(code)\"\n}"
//let postData = parameters.data(using: .utf8)
//
//var request = URLRequest(url: URL(string: "https://api.fellasloaded.com/api/user/password/reset/check_code/")!,timeoutInterval: Double.infinity)
//request.addValue("application/json", forHTTPHeaderField: "Accept")
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzE5NzQ1ODgzLCJpYXQiOjE3MTcxNTM4ODMsImp0aSI6IjhhZmQ4OWNhZTU1YTQ3NWM5ZTM2ZTZmYjhkMzc3NTY0IiwidXNlcl9pZCI6MzU3MDB9.0SDWbrLHZglQl-YXTetnQdZFqRRnbZkPbiUwfJNTV1o", forHTTPHeaderField: "Authorization")
//
//request.httpMethod = "POST"
//request.httpBody = postData
//
//let task = URLSession.shared.dataTask(with: request) { data, response, error in
//  guard let data = data else {
//    print(String(describing: error))
//    return
//  }
//  print(String(data: data, encoding: .utf8)!)
//}
//
//task.resume()
