//
//  ContentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let isLoggedIn = FLUserJourney.shared.isSubscibedUserLoggedIn, isLoggedIn {
            Tabbar()
        } else {
            WelcomeScreen()
        }
    }
}

#Preview {
    ContentView()
}
