//
//  AuthLoginModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

struct AuthLoginModel: Codable {
    let type: String
    let errors: [AuthLoginModelErros]
    let access: String
    let refresh: String
}

struct AuthLoginModelErros: Codable {
    let code: String
    let detail: String
}
