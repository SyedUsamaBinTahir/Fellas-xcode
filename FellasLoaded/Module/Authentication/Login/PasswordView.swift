//
//  PasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct PasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToForgotPassword = false
    
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
                    
                    if horizontalSizeClass != .regular {
                        Image("fellas-loaded-logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 144, height: 62, alignment: .center)
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading, spacing: 30) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if horizontalSizeClass == .regular {
                            Image("fellas-loaded-logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 226, height: 98)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 36)
                        }
                        
                        Text("Enter you password")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                    }
                    
                    VStack(spacing: 20) {
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
                        
                        FLButton(action: {
                            
                        }, title: "LOG IN", background: Color.white, foreground: Color.black)
                        
                        Button {
                            redirectToForgotPassword = true
                        } label: {
                            Text("Forgot password?")
                                .font(.custom(Font.bold, size: 16))
                                .foregroundStyle(Color.white)
                                .padding(.top)
                        }

                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
//                .navigationDestination(isPresented: $redirectToCreatepassword) {
//                    CreatePasswordView()
//                        .navigationBarBackButtonHidden(true)
//                }
                .navigationDestination(isPresented: $redirectToForgotPassword) {
                    ForgotPasswordView().navigationBarBackButtonHidden(true)
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
    PasswordView()
}
