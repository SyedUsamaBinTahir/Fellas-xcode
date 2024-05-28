//
//  PasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI
import ExytePopupView

struct PasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Binding var password: String
    @Binding var email: String
    @State private var redirectToForgotPassword = false
    @State private var redirectTabbarView = false
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    EmailHeaderView()
                    
                    VStack(alignment: .leading, spacing: 30) {
                        
                        PasswordLablesView()
                        
                        PasswordFieldAndButtonView(password: $password, redirectTabbarView: $viewModel.redirectTabbarView, redirectToForgotPassword: $redirectToForgotPassword, isValidPassword: .constant(password.count < 8 ? true : false), isDisabled: .constant(password.count < 8 ? true : false), setOpacity: .constant(password.count < 8 ? 0.6 : 1)) {
                            viewModel.showLoader = true
                            viewModel.getAccessToken(email: email, password: password)
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
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
                
                .navigationDestination(isPresented: $viewModel.redirectTabbarView) {
                    Tabbar()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $redirectToForgotPassword) {
                    ForgotPasswordView().navigationBarBackButtonHidden(true)
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
    PasswordView(password: .constant(""), email: .constant(""))
}
