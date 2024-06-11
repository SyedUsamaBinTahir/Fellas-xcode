//
//  ChangePasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var regirectForgotPassword = false
    
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
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Set new password")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                        
                        Text("Once you tap ‘Change password’, you’ll be logged out and asked to log in with your new password.")
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Password")
                                        .font(.custom(Font.regular, size: 11))
                                        .foregroundStyle(Color.theme.textGrayColor)
                                    SecureField("", text: $email)
                                        .font(.custom(Font.regular, size: 16))
                                        .foregroundStyle(Color.white)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Image("eye-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .padding(.horizontal, 10)
                            .frame(height: 48)
                            .background(Color.theme.appGrayColor)
                            .cornerRadius(10)
                            
                            Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                                .font(.custom(Font.Medium, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        VStack(spacing: 20) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Retype password")
                                        .font(.custom(Font.regular, size: 11))
                                        .foregroundStyle(Color.theme.textGrayColor)
                                    SecureField("", text: $email)
                                        .font(.custom(Font.regular, size: 16))
                                        .foregroundStyle(Color.white)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Image("eye-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                            }
                            .padding(.horizontal, 10)
                            .frame(height: 48)
                            .background(Color.theme.appGrayColor)
                            .cornerRadius(10)
                            
                            AuthButtonView(action: {
                            }, title: "SET NEW PASSWORD", background: Color.white, foreground: Color.black)
                            
                            Button {
                                regirectForgotPassword = true
                            } label: {
                                Text("Forgot password?")
                                    .font(.custom(Font.bold, size: 16))
                                    .foregroundStyle(Color.white)
                                    .padding(.top)
                            }
                        }
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
//                .navigationDestination(isPresented: $regirectForgotPassword) {
//                    ForgotPasswordView().navigationBarBackButtonHidden(true)
//                }
                
                NavigationLink(isActive: $regirectForgotPassword) {
                    ForgotPasswordView().navigationBarBackButtonHidden(true)
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
    ChangePasswordView()
}
