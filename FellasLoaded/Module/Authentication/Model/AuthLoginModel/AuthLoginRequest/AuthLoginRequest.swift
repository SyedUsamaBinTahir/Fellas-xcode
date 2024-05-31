//
//  AuthLoginRequest.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation

struct AuthLoginRequest: Codable {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
