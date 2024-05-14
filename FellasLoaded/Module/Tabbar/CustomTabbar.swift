//
//  CustomTabbar.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case vault
    case profile
}

struct CustomTabbar: View {
    @Binding var selectedTab: Tab
    private var selectedImage: String {
        selectedTab.rawValue + "Selected"
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack(spacing: 5) {
                        Image(selectedTab == tab ? selectedImage : tab.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24, alignment: .center)
                        Text(tab.rawValue.capitalized)
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.white)
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 14, height: 2)
                            .cornerRadius(10)
                    }
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                    Spacer()
                }
            }
            .background(Color.theme.tabbarColor)
        }
    }
}

#Preview {
    CustomTabbar(selectedTab: .constant(.home))
}
