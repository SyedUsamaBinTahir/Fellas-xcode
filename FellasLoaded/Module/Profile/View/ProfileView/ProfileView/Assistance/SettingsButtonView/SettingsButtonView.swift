//
//  SettingsButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SettingsButtonView: View {
    @Binding var redirectSettings: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                redirectSettings = true
            }, label: {
                Image("settings-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            })
        }
        .padding()
        .padding(.top, 30)
    }
}
