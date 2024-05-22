//
//  CreatePasswordFieldsAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CreatePasswordFieldsAndButtonView: View {
    @Binding var password: String
    @Binding var retypePassword: String
    @Binding var redirectToCheckEmailView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                AuthPasswordTextFieldView(placeholder: .constant("Password"), field: $password)
                
                Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                    .font(.custom(Font.Medium, size: 14))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            VStack(spacing: 20) {
                AuthPasswordTextFieldView(placeholder: .constant("Retype password"), field: $retypePassword)
                
                AuthButtonView(action: {
                    redirectToCheckEmailView = true
                }, title: "CONTINUE", background: Color.white, foreground: Color.black)
            }
        }
        .padding(.top, 20)
    }
}
