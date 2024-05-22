//
//  ResetPasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToCheckEmailView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                ForgotPasswordHeaderView()
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    ForgotPasswordLablesView()
                    
                    ForgotPasswordFieldAndButtonView(email: $email, redirectToCheckEmailView: $redirectToCheckEmailView)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToCheckEmailView) {
                    ResetPasswordView()
                        .navigationBarBackButtonHidden(true)
                }
                
                Spacer()
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ForgotPasswordView()
}
