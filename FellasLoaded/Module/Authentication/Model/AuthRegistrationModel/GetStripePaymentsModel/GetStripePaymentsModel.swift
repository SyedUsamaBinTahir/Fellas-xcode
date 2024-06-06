//
//  GetStripePaymentsModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 03/06/2024.
//

import Foundation

struct GetStripePaymentsModel: Codable {
    let id: Int
    let platform: String
    let name: String
    let subscription_id: String
    let bundle_id: String
    let trial_period: Int
    let best_value: Bool
    let amount: String
    let price_type: String
}
