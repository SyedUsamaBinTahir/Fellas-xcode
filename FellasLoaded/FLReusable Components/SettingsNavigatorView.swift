//
//  SettingsNavigatorView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct SettingsNavigatorView: View {
    var icon: String?
    var title: String = ""
    var description: String?
    var forwardIcon: String?
    @State var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack {
                HStack(spacing: 20) {
                    if let icon = icon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.custom(Font.semiBold, size: 16))
                        if let description = description {
                            Text(description)
                                .font(.custom(Font.Medium, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                    }
                    Spacer()
                    
                    if let forwardIcon = forwardIcon {
                        Image(forwardIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                .foregroundStyle(Color.white)
                
                Rectangle()
                    .fill(Color.theme.appGrayColor.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .padding(.top)
            }
        }
    }
}

#Preview {
    SettingsNavigatorView()
}
