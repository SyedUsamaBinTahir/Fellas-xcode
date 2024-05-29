//
//  AuthVerifyEmailRequest.swift
//  FellasLoaded
//
//  Created by Phebsoft on 29/05/2024.
//

import Foundation

struct AuthVerifyEmailRequest: Codable {
    let email: String
    let code_candidate: String
}
