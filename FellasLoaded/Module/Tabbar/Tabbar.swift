//
//  Tabbar.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct Tabbar: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if selectedTab == .home {
                    FeedView()
                } else if selectedTab == .vault {
                    VaultView()
                } else if selectedTab == .profile {
                    ProfileView()
                }
                
                CustomTabbar(selectedTab: $selectedTab)
            }
            .navigationBarHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Tabbar()
}
