//
//  ChangePasswordViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 12/07/2024.
//

import Foundation
import Combine

protocol ChangePasswordBased {
    func changePassword(oldPassword: String, newPassword: String)
}

class ChangePasswordViewModel: ObservableObject, FLViewModelProtocol, ChangePasswordBased {
    // cancel variabale after success response
    var subscriptions = Set<AnyCancellable>()
    
    // show loader and dismiss loader after success rseponse
    var showLoader: Bool = false
    @Published var showAlert: Bool = false
    var alertMessage: String = ""
   @Published var isSuccess: Bool = false
    
    
}

extension ChangePasswordViewModel {
    func changePassword(oldPassword: String, newPassword: String) {
        ChangePasswordApiService.shared.changePassword(oldPassword: oldPassword, newPassword: newPassword)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("ERROR", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false                        
                    }
                case .finished:
                    print("SUCCESS")
                    self?.alertMessage = "Password Change Successfully"
                    self?.showLoader = false
                    self?.showAlert = true
                    self?.isSuccess = true
                    print("SUCCESS STATUS: \(self?.isSuccess)")
                    UserDefaults.standard.setValue(newPassword, forKey: FLUserDefaultKeys.savePassword.rawValue)
                }
                
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscriptions)
    }
}
