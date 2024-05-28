//
//  FLEmailValidation.swift
//  FellasLoaded
//
//  Created by Phebsoft on 28/05/2024.
//

import Foundation

// MARK: - Is Valid Email
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

extension String {
    func isPasswordValid() -> Bool{
            let passwordFormat = "^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordTest.evaluate(with: self)
        }
}

// MARK: - Has Special Characters
extension String {
    func hasSpecialCharacters() -> Bool {
        var boolToReturn = false
        
        for word in self.components(separatedBy: " ") {
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: .caseInsensitive)
                if let _ = regex.firstMatch(in: word, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, word.count)) {
                    boolToReturn = true
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
        return boolToReturn
    }
}
