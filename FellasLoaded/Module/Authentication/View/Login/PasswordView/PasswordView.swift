//
//  PasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct PasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var password: String = ""
    @State private var redirectToForgotPassword = false
    @State private var redirectTabbarView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                EmailHeaderView()
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    PasswordLablesView()
                    
                    PasswordFieldAndButtonView(password: $password, redirectTabbarView: $redirectTabbarView, redirectToForgotPassword: $redirectToForgotPassword)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                Spacer()
            }
            .navigationDestination(isPresented: $redirectTabbarView) {
                Tabbar()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectToForgotPassword) {
                ForgotPasswordView().navigationBarBackButtonHidden(true)
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PasswordView()
}
