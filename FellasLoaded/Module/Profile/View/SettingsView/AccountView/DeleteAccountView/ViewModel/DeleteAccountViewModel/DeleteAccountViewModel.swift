//
//  DeleteAccountViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 18/07/2024.
//

import Foundation
import Combine

protocol DeleteAccountBase {
    func deleteAccount()
}

class DeleteAccountViewModel: ObservableObject, FLViewModelProtocol, DeleteAccountBase {
    var subscription = Set<AnyCancellable>()
    
    var showLoader: Bool = false
    @Published var showAlert: Bool = false
    var alertMessage: String = ""
    @Published var isSuccess: Bool = false
}


extension DeleteAccountViewModel {
    func deleteAccount() {
        DeleteAccountApiService.shared.deleteAccount()
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("ERROR", error.localizedDescription)
                    DispatchQueue.main.async{
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("SUCCESS")
                    self?.alertMessage = "Account deleted successfully"
                    self?.showLoader = false
                    self?.showAlert = true
                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
}
