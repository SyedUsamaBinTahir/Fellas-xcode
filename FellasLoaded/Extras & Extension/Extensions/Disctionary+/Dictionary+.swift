//
//  Dictionary+.swift
//  FellasLoaded
//
//  Created by Phebsoft on 27/05/2024.
//

import Foundation

public extension Dictionary {
    
    func printAsJSON() {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let theJSONText = String(data: theJSONData, encoding: String.Encoding.ascii) {
            print("\(theJSONText)")
        }
    }
}
