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
    @Binding var showButtonLoader: Bool
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

            if showButtonLoader {
                FLButtonLoader(color: .constant(Color.theme.textGrayColor))
                    .font(.custom(Font.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
            } else {
                AuthButtonView(action: {
                    verifyEmailAction()
                }, title: "CONTINUE", background: Color.white, foreground: Color.black)
            }
        }
        .padding(.top, 30)
    }
}
