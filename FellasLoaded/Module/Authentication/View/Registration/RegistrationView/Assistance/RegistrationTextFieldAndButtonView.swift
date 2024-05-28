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
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Email", placeHolder: "") {
            }
            
            AuthButtonView(action: {
                action()
            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
        }
        .padding(.top, 30)
    }
}
