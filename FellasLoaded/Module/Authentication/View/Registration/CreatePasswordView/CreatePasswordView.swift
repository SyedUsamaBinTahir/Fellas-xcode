//
//  CreatePasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI
import ExytePopupView

struct CreatePasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Binding var email: String
    @Binding var password: String
    @State private var retypePassword: String = ""
    @State private var isValidPassword = false
    @State private var isDisabled = false
    @State private var setOpacity: Double = 0.6
    @State private var redirectToCheckEmailView = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 2 OF 5"))
                    
                    VStack(alignment: .leading) {
                        
                        CreatePasswordLablesView()
                        
                        CreatePasswordFieldsAndButtonView(password: $password, retypePassword: $retypePassword, isValidPassword: $isValidPassword, isDisabled: $isDisabled, setOpacity: $setOpacity) {
                            viewModel.showLoader = true
                            viewModel.registerUser(email: email, password: password)
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
                .onChange(of: password) { _ in
                    if password.isPasswordValid() {
                        isValidPassword = false
                    } else {
                        isValidPassword = true
                    }
                }
                .onChange(of: retypePassword) { _ in
                    if retypePassword == password {
                        isDisabled = false
                        setOpacity = 1
                    } else {
                        isDisabled = true
                        setOpacity = 0.6
                    }
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
                .navigationDestination(isPresented: $viewModel.redirectToCheckEmailView) {
                    CheckEmailView(email: $email).navigationBarBackButtonHidden(true)
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
    CreatePasswordView(email: .constant(""), password: .constant(""))
}
