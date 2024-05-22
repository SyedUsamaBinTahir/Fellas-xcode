//
//  ForgotPasswordFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ForgotPasswordFieldAndButtonView: View {
    @Binding var email: String
    @Binding var redirectToCheckEmailView: Bool
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Email", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                redirectToCheckEmailView = true
            }, title: "SUBMIT", background: Color.white, foreground: Color.black)
        }
    }
}
