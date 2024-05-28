//
//  SignUpView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToCreatepassword = false
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 1 OF 5"))
                    
                    VStack(alignment: .leading) {
                        
                        RegistrationLablesView()
                        
                        RegistrationTextFieldAndButtonView(email: $email, redirectToCreatepassword: $redirectToCreatepassword) {
                            viewModel.showLoader = true
                            viewModel.registerUser(email: email, password: "121312312")
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    .navigationDestination(isPresented: $viewModel.redirectToCreatepassword) {
                        CreatePasswordView()
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
    RegistrationView()
}
