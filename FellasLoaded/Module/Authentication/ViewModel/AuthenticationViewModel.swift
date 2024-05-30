//
//  AuthenticationViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject, FLViewModelProtocol {
    var subscriptions = Set<AnyCancellable>()
    @Published var authError: FLAuthError? = nil
    @Published var redirectTabbarView = false
    @Published var redirectToCheckEmailView = false
    @Published var redirectToDisplayNameAndImageView = false
    @Published var redirectToResetPasswordView = false
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var didLogin = false
    
    func getAccessToken(email: String, password: String) {
        
        DataService.shared.getAccessToken(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] complete in
                switch complete {
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(String(describing: error.errorDescription))
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectTabbarView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)

    }
    
    func registerUser(email: String, password: String) {
        AuthRegistraionAPIService.shared.registerRequest(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] complete in
                switch complete {
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(String(describing: error.errorDescription))
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectToCheckEmailView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func checkEamilResendCode(email: String) {
        print("EMAIL -->",email)
        CheckEmailAPIService.shared.registerRequest(email: email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    DispatchQueue.main.async {
                        print(error)
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func verifyEmailRequest(email: String, code: String) {
        AuthVerfiyEmailAPIService.shared.registerRequest(email: email, code: code)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    DispatchQueue.main.async {
                        print(error)
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectToDisplayNameAndImageView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func sendForgotPasswordCodeRequest(email: String) {
        ForgotPasswordAPIService.shared.requestForgotPasswordCode(email: email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                        self?.showAlert = true
                    }
                case .finished:
                    print("success --> ",completion)
                    self?.showLoader = false
                    self?.redirectToResetPasswordView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)

    }
    
    func verifyForgotPasswordCodeRequest(email: String, code: String) {
        CodeVerificationAPIService.shared.verifyForgotPasswordCode(email: email, code: code)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    DispatchQueue.main.async {
                        print(error)
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectToDisplayNameAndImageView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
//    func getLoginAccessToken(email: String, password: String) {
//        
//        let doesThrowError = throwErrorIfValueInvalid(email: email, password: password)
//        
//        if doesThrowError {
//            showAlert = true
//            showLoader = false
//            didLogin = false
//        }
//        
//        let params: [String: Any] = [
//            "email": email,
//            "password": password
//        ]
//        print(params)
//        
//        if let url = URL(string: "https://api.fellasloaded.com/api/user/auth/email/") {
//            APIService.shared.postRequest(url: url, params: params, type: AuthLoginModel.self, completionHandler: { (response) in
//                self.showLoader = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    print("Response -->" ,response)
//                    self.showLoader = false
//                    self.didLogin = true
//                    self.redirectTabbarView = true
//                }
//            }) { (error) in
//                print(String(describing: error))
//                self.didLogin = false
//                self.showLoader = false
//                self.showAlert = true
//            }
//        }
//    }
    
}
