//
//  CheckEmailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct CheckEmailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AuthenticationViewModel()
    @Binding var email: String
    @State private var code: String = ""
    @State private var redirectToDisplayNameAndImageView = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 3 OF 5"))
                    
                    VStack(alignment: .leading) {
                        
                        CheckEmailLablesView()
                        
                        CheckEmailFieldAndButtonView(code: $code, redirectToDisplayNameAndImageView: $redirectToDisplayNameAndImageView) {
                            viewModel.showLoader = true
                            viewModel.checkEamilResendCode(email: email)
                        } verifyEmailAction: {
                            viewModel.showLoader = true
                            viewModel.verifyEmailRequest(email: email, code: code)
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
                    .navigationDestination(isPresented: $viewModel.redirectToDisplayNameAndImageView) {
                        DisplayNameAndImageView()
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
    CheckEmailView(email: .constant(""))
}
