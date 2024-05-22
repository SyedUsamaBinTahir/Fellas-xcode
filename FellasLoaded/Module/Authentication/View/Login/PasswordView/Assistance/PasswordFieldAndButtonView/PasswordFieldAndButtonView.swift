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
    
    var body: some View {
        VStack(spacing: 20) {
            AuthPasswordTextFieldView(placeholder: .constant("password"), field: $password)
            
            AuthButtonView(action: {
                redirectTabbarView = true
            }, title: "LOG IN", background: Color.white, foreground: Color.black)
            
            Button {
                redirectToForgotPassword = true
            } label: {
                Text("Forgot password?")
                    .font(.custom(Font.bold, size: 16))
                    .foregroundStyle(Color.white)
                    .padding(.top)
            }

        }
    }
}
