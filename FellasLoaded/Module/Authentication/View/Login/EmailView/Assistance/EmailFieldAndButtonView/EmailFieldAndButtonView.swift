//
//  EmailFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EmailFieldAndButtonView: View {
    @Binding var email: String
    @Binding var redirectToPasswordView: Bool
    @Binding var isDisabled: Bool
    @Binding var setOpacity: Double
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $email, title: "Email", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                redirectToPasswordView = true
            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
            .disabled(isDisabled)
            .opacity(setOpacity)
        }
    }
}
