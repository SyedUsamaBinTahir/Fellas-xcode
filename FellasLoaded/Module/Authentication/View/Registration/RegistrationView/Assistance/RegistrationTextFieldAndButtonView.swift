//
//  RegistrationTextFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct RegistrationTextFieldAndButtonView: View {
    @Binding var email: String
    @Binding var redirectToCreatepassword: Bool
    @Binding var isDisabled: Bool
    @Binding var setOpacity: Double
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Email", placeHolder: "") {
            }
            
            AuthButtonView(action: {
                redirectToCreatepassword = true
            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
            .disabled(isDisabled)
            .opacity(setOpacity)
        }
        .padding(.top, 30)
    }
}
