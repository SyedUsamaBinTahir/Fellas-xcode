//
//  ResetPasswordFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ResetPasswordFieldAndButtonView: View {
    @Binding var code: String
    @Binding var redirectToNewPasswordView: Bool
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $code, title: "Code", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                action()
            }, title: "RESET PASSWORD", background: Color.white, foreground: Color.black)
        }
    }
}
