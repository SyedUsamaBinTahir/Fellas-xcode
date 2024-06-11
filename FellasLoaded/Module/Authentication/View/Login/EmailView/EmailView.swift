//
//  EmailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var redirectToPasswordView = false
    @State private var isDisabled = false
    @StateObject var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                EmailHeaderView()
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    EmailLablesView()
                    
                    EmailFieldAndButtonView(email: $email, redirectToPasswordView: $redirectToPasswordView, isDisabled: .constant(email.isValidEmail() ? false : true), setOpacity: .constant(email.isValidEmail() ? 1 : 0.6))
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
//                .navigationDestination(isPresented: $redirectToPasswordView) {
//                    PasswordView(password: $password, email: $email)
//                        .environmentObject(viewModel)
//                        .navigationBarBackButtonHidden(true)
//                }
                
                NavigationLink(isActive: $redirectToPasswordView) {
                    PasswordView(password: $password, email: $email)
                        .environmentObject(viewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
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
    EmailView()
}
