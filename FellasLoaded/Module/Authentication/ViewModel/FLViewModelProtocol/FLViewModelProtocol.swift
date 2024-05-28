//
//  FLViewModelProtocol.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

protocol FLViewModelProtocol {
    func checkIfConnectedToNetwork() -> Bool
}

extension FLViewModelProtocol {
    func checkIfConnectedToNetwork() -> Bool  {
        if !SystemReachability.isConnectedToNetwork() {
            return false
        } else {
            return true
        }
    }
}
