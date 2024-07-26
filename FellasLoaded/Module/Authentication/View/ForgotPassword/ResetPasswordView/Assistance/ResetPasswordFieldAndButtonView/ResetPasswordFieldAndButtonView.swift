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
    @Binding var showButtonLoader: Bool
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $code, title: "Code", placeHolder: "") {
                
            }
            
            if showButtonLoader {
                FLButtonLoader(color: .constant(Color.theme.textGrayColor))
                    .font(.custom(Font.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
            } else {
                AuthButtonView(action: {
                    action()
                }, title: "RESET PASSWORD", background: Color.white, foreground: Color.black)
            }
        }
    }
}
