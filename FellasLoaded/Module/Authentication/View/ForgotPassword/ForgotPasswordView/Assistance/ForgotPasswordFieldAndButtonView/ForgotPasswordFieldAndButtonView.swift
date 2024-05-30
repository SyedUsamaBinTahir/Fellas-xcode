//
//  ForgotPasswordFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ForgotPasswordFieldAndButtonView: View {
    @Binding var email: String
    @Binding var redirectToResetPasswordView: Bool
    @State var action: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Email", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                action()
            }, title: "SUBMIT", background: Color.white, foreground: Color.black)
        }
    }
}
