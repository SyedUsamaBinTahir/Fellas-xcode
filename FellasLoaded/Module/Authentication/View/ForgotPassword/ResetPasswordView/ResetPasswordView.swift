//
//  ResetPasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Binding var email: String
    @State var code: String = ""
    @State private var redirectToNewPasswordView = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    ResetPasswordHeaderView()
                    
                    VStack(alignment: .leading, spacing: 30) {
                        
                        ResetPasswordLablesView()
                        
                        ResetPasswordFieldAndButtonView(code: $code, redirectToNewPasswordView: $redirectToNewPasswordView) {
                            viewModel.showLoader = true
                            viewModel.verifyForgotPasswordCodeRequest(email: email, code: code)
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    .popup(isPresented: $viewModel.showAlert) {
                        FLToastAlert(image: .constant(""), message: .constant(viewModel.alertMessage))
                    } customize: {
                        $0
                            .type(.floater(useSafeAreaInset: true))
                            .position(.top)
                            .animation(.spring())
                            .closeOnTapOutside(true)
                            .backgroundColor(.black.opacity(0.5))
                            .autohideIn(3)
                            .appearFrom(.top)
                    }
                    .navigationDestination(isPresented: $viewModel.redirectToNewPasswordView) {
                        NewPasswordView(code: $code)
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
    ResetPasswordView(email: .constant(""))
}
