//
//  CheckEmailFieldButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CheckEmailFieldAndButtonView: View {
    @Binding var code: String
    @Binding var redirectToDisplayNameAndImageView: Bool
    @State var resentEmailAction: () -> Void
    @State var verifyEmailAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $code, title: "Code", placeHolder: "") {
                
            }
            
            Button {
                resentEmailAction()
            } label: {
                Text("RESEND EMAIL")
                    .font(.custom(Font.bold, size: 16))
                    .foregroundStyle(Color.white)
                    .padding(.top)
            }

            AuthButtonView(action: {
                verifyEmailAction()
            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
        }
        .padding(.top, 30)
    }
}
