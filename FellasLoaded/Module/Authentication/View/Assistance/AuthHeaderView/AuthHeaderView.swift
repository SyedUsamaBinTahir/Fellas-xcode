//
//  AuthHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct AuthHeaderView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Binding var step: String
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
                    Text(step)
                        .font(.custom(Font.semiBold, size: 16))
                        .foregroundStyle(Color.theme.textGrayColor)
                }
            }
        }
        .padding(.top, 50)
        
        if horizontalSizeClass != .regular {
            Rectangle()
                .fill(Color.theme.appGrayColor.opacity(0.6))
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
}

#Preview {
    AuthHeaderView(step: .constant("STEP 1 OF 5"))
}
