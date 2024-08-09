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
            ZStack (alignment: .leading) {
                Text("Email")
                    .foregroundColor(Color.theme.textGrayColor)
                    .offset(y: self.email.isEmpty ? 0  : -20)
    //                .scaleEffect(self.field.isEmpty ? 1 : 0.9, anchor: .leading)
                    .font(.custom(Font.regular, size: 11))
                
                TextField("", text: $email)
                    .font(.custom(Font.regular, size: 16))
                    .foregroundStyle(Color.white)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .submitLabel(.done)
            }
            .padding(.top, self.email.isEmpty ? 0 : 10)
            .animation(.default, value: !email.isEmpty)
            .padding(10)
            .frame(height: 48)
            .background(Color.theme.appGrayColor)
            .cornerRadius(6)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(email.isEmpty ? Color.clear : .white, lineWidth: 2.2)
            )
            
            AuthButtonView(action: {
                redirectToPasswordView = true
                print("email --> ",email)
            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
            .disabled(isDisabled)
            .opacity(setOpacity)
        }
    }
}
