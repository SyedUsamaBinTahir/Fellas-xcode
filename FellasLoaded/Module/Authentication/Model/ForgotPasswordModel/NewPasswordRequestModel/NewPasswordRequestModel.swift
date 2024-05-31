//
//  NewPasswordRequestModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 31/05/2024.
//

import Foundation

struct NewPasswordRequestModel: Codable {
    let code_candidate: String
    let password_candidate: String
}
