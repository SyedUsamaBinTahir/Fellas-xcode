//
//  NewPasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct NewPasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @Binding var code: String
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var retypePassword: String = ""
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    NewPasswordHeaderView()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Change your password")
                                .font(.custom(Font.semiBold, size: 32))
                                .foregroundStyle(Color.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading, spacing: 18) {
                                AuthPasswordTextFieldView(placeholder: .constant("Password"), field: $currentPassword)
                                                                
                                Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                                    .font(.custom(Font.Medium, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                            
                            VStack(spacing: 20) {
                                AuthPasswordTextFieldView(placeholder: .constant("Retype Password"), field: $newPassword)
                                
                                if viewModel.showLoader {
                                    FLButtonLoader(color: .constant(Color.theme.textGrayColor))
                                        .font(.custom(Font.bold, size: 16))
                                        .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                                        .background(Color.white)
                                        .foregroundColor(Color.black)
                                        .cornerRadius(10)
                                } else {
                                    AuthButtonView(action: {
                                        viewModel.showLoader = true
                                        viewModel.setNewPasswordRequest(code: code, password: currentPassword)
                                    }, title: "CHANGE PASSWORD", background: Color.white, foreground: Color.black)
                                }
                            }
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
                .onChange(of: viewModel.redirectToWelcomPage, perform: { _ in
                    self.viewControllerHolder?.present(style: .overFullScreen) {
                        WelcomeScreen()
                    }
                })
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
    NewPasswordView( code: .constant(""))
}
