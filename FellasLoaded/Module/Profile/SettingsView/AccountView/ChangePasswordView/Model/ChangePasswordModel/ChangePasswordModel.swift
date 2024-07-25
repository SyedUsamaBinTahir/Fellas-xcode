//
//  ChangePasswordModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 12/07/2024.
//

import Foundation

struct ChangePasswordModel: Codable {
    let old_password: String
    let new_password: String
}
