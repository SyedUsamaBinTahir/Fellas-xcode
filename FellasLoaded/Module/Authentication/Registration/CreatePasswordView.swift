//
//  CreatePasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToCheckEmailView = false
    
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
                        HStack {
                            Text("STEP 2 OF 5")
                                .font(.custom(Font.semiBold, size: 16))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                    }
                }
                .padding(.top, 50)
                
                if horizontalSizeClass != .regular {
                    Rectangle()
                        .fill(Color.theme.appGrayColor.opacity(0.6))
                        .frame(maxWidth: .infinity, maxHeight: 2)
                }
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if horizontalSizeClass == .regular {
                            Text("STEP 2 OF 5")
                                .font(.custom(Font.semiBold, size: 16))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        Text("Create a password")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
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
                            
                            FLButton(action: {
                                redirectToCheckEmailView = true
                            }, title: "CONTINUE", background: Color.white, foreground: Color.black)
                        }
                    }
                    .padding(.top, 20)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToCheckEmailView) {
                    CheckEmailView().navigationBarBackButtonHidden(true)
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
    CreatePasswordView()
}
