//
//  DeleteAccountView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct DeleteAccountView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var password: String = ""
    @State private var redirectToDisplayNameAndImageView = false
    
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
                
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("Delete your account?")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                        
                        Text("By deleting your account, all your data will be erased, and your account will be permanently deleted. This action cannot be reversed.")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Password")
                                        .font(.custom(Font.regular, size: 11))
                                        .foregroundStyle(Color.theme.textGrayColor)
                                    SecureField("", text: $password)
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
                        }
                        
                        HStack(spacing: 16) {
                            Image("check-mark-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: .center)
                            Text("I am sure I want to delete my account.")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.white)
                        }
                        
                        HStack(spacing: 16) {
                            Image("check-mark-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24, alignment: .center)
                            Text("I am aware that deleting my account will remove all my data.")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    AuthButtonView(action: {
                        redirectToDisplayNameAndImageView = true
                    }, title: "DELETE MY ACCOUNT", background: Color.white, foreground: Color.black)
                    .padding(.bottom, 30)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToDisplayNameAndImageView) {
                    DisplayNameAndImageView()
                        .navigationBarBackButtonHidden(true)
                }
                
                NavigationLink(isActive: $redirectToDisplayNameAndImageView) {
                    DisplayNameAndImageView()
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
    DeleteAccountView()
}
