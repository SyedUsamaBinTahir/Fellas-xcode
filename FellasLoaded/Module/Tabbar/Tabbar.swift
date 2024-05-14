//
//  Tabbar.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct Tabbar: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.theme.tabbarColor)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white)
    }
    
    var body: some View {
        TabView {
            WelcomeScreen()
                .tabItem {
                    VStack {
                        Image("home-icon")
                        Text("Home")
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 114, height: 5)
                    }
                }
            EmailView()
                .tabItem {
                    Image("vault-icon")
                    Text("Home")
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 114, height: 5)
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        .foregroundStyle(.white)
                    Text("Home")
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 114, height: 5)
                }
        }
        .tint(Color.white)
    }
}

#Preview {
    Tabbar()
}
