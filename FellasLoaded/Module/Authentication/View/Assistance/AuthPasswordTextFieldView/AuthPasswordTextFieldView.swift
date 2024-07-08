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
            ZStack (alignment: .leading) {
                Text(placeholder)
                    .foregroundColor(Color.theme.textGrayColor)
                    .offset(y: self.field.isEmpty ? 0  : -20)
    //                .scaleEffect(self.field.isEmpty ? 1 : 0.9, anchor: .leading)
                    .font(.custom(Font.regular, size: 11))
                
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
        .padding(.top, self.field.isEmpty ? 0 : 10)
        .animation(.default, value: !field.isEmpty)
        .padding(10)
        .frame(height: 48)
        .background(Color.theme.appGrayColor)
        .cornerRadius(6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(field.isEmpty ? Color.clear : .white, lineWidth: 2.2)
        )
    }
}
