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
    @State private var password: String = ""
    @State private var redirectToCreatepassword = false
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    AuthHeaderView(step: .constant("STEP 1 OF 5"))
                    
                    VStack(alignment: .leading) {
                        
                        RegistrationLablesView()
                        
                        RegistrationTextFieldAndButtonView(email: $email, redirectToCreatepassword: $redirectToCreatepassword, isDisabled: .constant(email.isValidEmail() ? false : true), setOpacity: .constant(email.isValidEmail() ? 1: 0.6))
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
//                    .navigationDestination(isPresented: $redirectToCreatepassword) {
//                        CreatePasswordView(email: $email, password: $password)
//                            .environmentObject(viewModel)
//                            .navigationBarBackButtonHidden(true)
//                    }
                    
                    NavigationLink(isActive: $redirectToCreatepassword) {
                        CreatePasswordView(email: $email, password: $password)
                            .environmentObject(viewModel)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        EmptyView()
                    }

                    Spacer()
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
