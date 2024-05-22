//
//  ResetPasswordFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ResetPasswordFieldAndButtonView: View {
    @Binding var email: String
    @Binding var redirectToNewPasswordView: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Code", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                redirectToNewPasswordView = true
            }, title: "RESET PASSWORD", background: Color.white, foreground: Color.black)
        }
    }
}
