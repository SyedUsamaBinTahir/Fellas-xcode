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
    @Binding var isValidPassword: Bool
    @Binding var isDisabled: Bool
    @Binding var setOpacity: Double
    @State var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                AuthPasswordTextFieldView(placeholder: .constant("Password"), field: $password)
                
                if isValidPassword {
                    Text("Invalid Password")
                        .font(.custom(Font.regular, size: 14))
                        .foregroundStyle(Color.theme.appRedColor)
                }
                
                Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                    .font(.custom(Font.Medium, size: 14))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            VStack(spacing: 20) {
                AuthPasswordTextFieldView(placeholder: .constant("Retype password"), field: $retypePassword)
                
                AuthButtonView(action: {
                    action()
                }, title: "CONTINUE", background: Color.white, foreground: Color.black)
                .disabled(isDisabled)
                .opacity(setOpacity)
            }
        }
        .padding(.top, 20)
    }
}
