//
//  AuthenticationViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject, FLViewModelProtocol {
    // Cancel subscription after success variable
    var subscriptions = Set<AnyCancellable>()
    // Navigate after success variables
    @Published var redirectTabbarView = false
    @Published var redirectToCheckEmailView = false
    @Published var redirectToDisplayNameAndImageView = false
    @Published var redirectToResetPasswordView = false
    @Published var redirectToNewPasswordView = false
    
    // show loader after api calls variable
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func getAccessToken(email: String, password: String) {
        
        AuthLoginAPIService.shared.getAccessToken(email: email, password: password)
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
                    print("error: ", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectToNewPasswordView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
    
    func setNewPasswordRequest(code: String, password: String) {
        NewPasswordAPIService.shared.verifyForgotPasswordCode(code: code, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let  error):
                    print("error: ", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("success")
                    self?.showLoader = false
                    self?.redirectToNewPasswordView = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
}
