//
//  FLUserJourney.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

public final class FLUserJourney {
    static let shared = FLUserJourney()

    var authToken: String?
    var authRegistrationToken: String?
}

