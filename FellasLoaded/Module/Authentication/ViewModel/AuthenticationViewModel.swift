//
//  AuthenticationViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation
import Combine

protocol AuthenticationBased {
    func getAccessToken(email: String, password: String)
    func registerUser(email: String, password: String)
    func checkEamilResendCode(email: String)
    func verifyEmailRequest(email: String, code: String)
    func sendForgotPasswordCodeRequest(email: String)
    func verifyForgotPasswordCodeRequest(email: String, code: String)
    func setNewPasswordRequest(code: String, password: String)
}

class AuthenticationViewModel: ObservableObject, FLViewModelProtocol, AuthenticationBased {
    // Cancel subscription after success variable
    var subscriptions = Set<AnyCancellable>()
    // Navigate after success properties
    @Published var redirectTabbarView = false
    @Published var redirectToCheckEmailView = false
    @Published var redirectToDisplayNameAndImageView = false
    @Published var redirectToResetPasswordView = false
    @Published var redirectToNewPasswordView = false
    
    // show loader after api calls properties
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    // Services models
    @Published var getStripePaymentsModel = [GetStripePaymentsModel]()
    
}

extension AuthenticationViewModel {
    
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
    
    func getStripePaymentPrices() {
//        GetServerData.shared.getServerData(endpoint: .getPaymentPrices, type: GetStripePaymentsModel.self)
//            .sink { [weak self] completion in
//                switch completion {
//                case .failure(let error):
//                    print("\(error.localizedDescription)")
//                    DispatchQueue.main.async {
//                        self?.showAlert = true
//                        self?.alertMessage = error.localizedDescription
//                        self?.showLoader = false
//                    }
//                case .finished:
//                    print("Finished")
//                    self?.showLoader = false
//                }
//            }
//            receiveValue: { [weak self] resultData in
//                self?.getStripePaymentsModel = resultData
//            }
//            .store(in: &subscriptions)
        
//        GetPaymentPricesAPIService.shared.getPaymentsPrices()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                    switch completion {
//                    case .failure(let error):
//                        print(String(describing: error.localizedDescription))
//                        DispatchQueue.main.async {
//                            self?.showLoader = false
//                        }
//                    case .finished:
//                        print("success")
//                    }
//            } receiveValue: { getStripePayments in
//                self.getStripePaymentsModel = getStripePayments
//            }
//            .store(in: &self.subscriptions)
    }
}
