//
//  SettingsHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SettingsHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }).padding(.leading)
                
                Spacer()
            }
            
            if horizontalSizeClass != .regular {
                HStack {
                    Text(title)
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                }
            }
        }
        .padding(.top, 50)
    }
}
