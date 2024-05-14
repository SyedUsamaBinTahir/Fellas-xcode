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
    @State private var email: String = ""
    @State private var redirectToNewPasswordView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("back-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        }).padding(.leading)
                        
                        Spacer()
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Check your email")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                        Text("We've just sent a password reset code and link to your email address. Please check your inbox, and don't forget to take a look in your spam folder, just in case.")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(spacing: 20) {
                        FLTextField(field: $email, title: "Code", placeHolder: "") {
                            
                        }
                        
                        FLButton(action: {
                            redirectToNewPasswordView = true
                        }, title: "RESET PASSWORD", background: Color.white, foreground: Color.black)
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToNewPasswordView) {
                    NewPasswordView()
                        .navigationBarBackButtonHidden(true)
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
    ResetPasswordView()
}
