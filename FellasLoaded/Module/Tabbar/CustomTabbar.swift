//
//  CustomTabbar.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

enum  Tab: String, CaseIterable {
    case home
    case vault
    case profile
}

struct CustomTabbar: View {
    @Binding var selectedTab: Tab
    private var selectedImage: String {
        selectedTab.rawValue
    }
    
    var body: some View {
        HStack{
            ForEach (Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                VStack(spacing: 0) {
                    Image(selectedTab == tab ? selectedImage : tab.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text(tab.rawValue.capitalized)
                        .font(.caption)
                        .foregroundColor(.white)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                        .frame(width: 16, height: 3)
                }
                .onTapGesture {
                        selectedTab = tab
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 60)
        .background(Color.theme.tabbarColor)
    }
}

#Preview {
    CustomTabbar(selectedTab: .constant(.home))
}
