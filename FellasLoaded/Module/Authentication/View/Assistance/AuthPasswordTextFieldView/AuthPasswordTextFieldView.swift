//
//  AuthPasswordTextFieldView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct AuthPasswordTextFieldView: View {
    @Binding var placeholder: String
    @Binding var field: String
    @State private var showPassword = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(placeholder)
                    .font(.custom(Font.regular, size: 11))
                    .foregroundStyle(Color.theme.textGrayColor)
                if !showPassword {
                    SecureField("", text: $field)
                        .font(.custom(Font.regular, size: 16))
                        .foregroundStyle(Color.white)
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: $field)
                        .font(.custom(Font.regular, size: 16))
                        .foregroundStyle(Color.white)
                        .textInputAutocapitalization(.never)
                }
            }
            
            Button {
                showPassword.toggle()
            } label: {
                Image("eye-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 48)
        .background(Color.theme.appGrayColor)
        .cornerRadius(10)
    }
}
