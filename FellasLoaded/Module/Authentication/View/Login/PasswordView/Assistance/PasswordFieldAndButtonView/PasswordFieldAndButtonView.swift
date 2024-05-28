//
//  PasswordFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct PasswordFieldAndButtonView: View {
    @Binding var password: String
    @Binding var redirectTabbarView: Bool
    @Binding var redirectToForgotPassword: Bool
    @Binding var isValidPassword: Bool
    @Binding var isDisabled: Bool
    @Binding var setOpacity: Double
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthPasswordTextFieldView(placeholder: .constant("password"), field: $password)
            if isValidPassword {
                Text("Password must have atleast minimum of 8 characters")
                    .font(.custom(Font.regular, size: 14))
                    .foregroundStyle(Color.theme.appRedColor)
            }
            AuthButtonView(action: {
                action()
            }, title: "LOG IN", background: Color.white, foreground: Color.black)
            .disabled(isDisabled)
            .opacity(setOpacity)
            
            Button {
                redirectToForgotPassword = true
            } label: {
                Text("Forgot password?")
                    .font(.custom(Font.bold, size: 16))
                    .foregroundStyle(Color.white)
                    .padding(.top)
            }

        }
        .onAppear {
            isValidPassword = false
        }
    }
}
