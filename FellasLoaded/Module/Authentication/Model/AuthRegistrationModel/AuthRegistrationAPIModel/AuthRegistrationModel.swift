//
//  AuthRegistrationModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation

struct AuthRegistrationModel: Codable {
    let email: String
    let detail: String
    let access: String
    let refresh: String
}
