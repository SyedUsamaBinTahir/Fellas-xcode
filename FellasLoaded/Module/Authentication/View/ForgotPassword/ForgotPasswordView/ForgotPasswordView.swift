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
    @State private var redirectToResetPasswordView = false
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    ForgotPasswordHeaderView()
                    
                    VStack(alignment: .leading, spacing: 30) {
                        
                        ForgotPasswordLablesView()
                        
                        ForgotPasswordFieldAndButtonView(email: $email, redirectToResetPasswordView: $redirectToResetPasswordView) {
                            viewModel.showLoader = true
                            viewModel.sendForgotPasswordCodeRequest(email: email)
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    .navigationDestination(isPresented: $viewModel.redirectToResetPasswordView) {
                        ResetPasswordView(email: $email)
                            .environmentObject(viewModel)
                            .navigationBarBackButtonHidden(true)
                    }
                    
                    Spacer()
                }
                
                if viewModel.showLoader {
                    FLLoader()
                }
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
