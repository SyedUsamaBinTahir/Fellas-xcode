//
//  FLUserJourney.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/05/2024.
//

import Foundation

protocol FLUserJourneyBased {
    func subscribedUserLoggedin()
    func unSubscribedUserLoggedin()
    func logoutOccured()
    func checkIfSubscribedUserIsSignedIn() -> Bool
    func checkIfunSubscribedUserIsSignedIn() -> Bool
}

extension FLUserJourneyBased {
    func addAccountInformation(key: FLUserDefaultKeys, value: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func removeAccountInformation(key: FLUserDefaultKeys) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key.rawValue)
    }
}

public final class FLUserJourney {
    static let shared = FLUserJourney()

    var authToken: String?
    var authRegistrationToken: String?
    
    public var isSubscibedUserLoggedIn: Bool? {
        userDefaults.bool(forKey: FLUserDefaultKeys.subscribedUserloggedIn.rawValue)
    }
    
    public var isunSubscibedUserLoggedIn: Bool? {
        userDefaults.bool(forKey: FLUserDefaultKeys.unSubscribedUserLoggedIn.rawValue)
    }
    
    let userDefaults = UserDefaults.standard
}

extension FLUserJourney: FLUserJourneyBased {
    
    func subscribedUserLoggedin() {
        self.addAccountInformation(key: FLUserDefaultKeys.subscribedUserloggedIn, value: true)
        self.addAccountInformation(key: FLUserDefaultKeys.accesstoken, value: true)
    }
    
    func unSubscribedUserLoggedin() {
        self.addAccountInformation(key: FLUserDefaultKeys.unSubscribedUserLoggedIn, value: true)
        self.addAccountInformation(key: FLUserDefaultKeys.accesstoken, value: true)
    }
    
    // for test cases
    func checkIfunSubscribedUserIsSignedIn() -> Bool {
        if let isLoggedin = userDefaults.value(forKey: FLUserDefaultKeys.unSubscribedUserLoggedIn.rawValue) as? Bool {
            return isLoggedin
        } else {
            return false
        }
    }
    
    // for test cases
    func checkIfSubscribedUserIsSignedIn() -> Bool {
        if let isLoggedIn = userDefaults.value(forKey: FLUserDefaultKeys.subscribedUserloggedIn.rawValue) as? Bool {
            return isLoggedIn
        } else {
            return false
        }
    }
    
    func logoutOccured() {
        self.removeAccountInformation(key: FLUserDefaultKeys.subscribedUserloggedIn)
        self.removeAccountInformation(key: FLUserDefaultKeys.unSubscribedUserLoggedIn)
        self.removeAccountInformation(key: FLUserDefaultKeys.accesstoken)
    }
}
