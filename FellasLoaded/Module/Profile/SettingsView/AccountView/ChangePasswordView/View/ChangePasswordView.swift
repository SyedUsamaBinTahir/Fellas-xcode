//
//  ChangePasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI
import ExytePopupView

struct ChangePasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State private var regirectForgotPassword = false
    @StateObject var changePasswordViewModel = ChangePasswordViewModel()
    
    var body: some View {
        ZStack{
            VStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(Circle())
                        }).padding(.leading)
                        
                        Spacer()
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
                                //                                HStack {
                                //                                    VStack(alignment: .leading) {
                                //                                        Text("Old password")
                                //                                            .font(.custom(Font.regular, size: 11))
                                //                                            .foregroundStyle(Color.theme.iconsColor)
                                //                                        SecureField("", text: $oldPassword)
                                //                                            .font(.custom(Font.regular, size: 16))
                                //                                            .foregroundStyle(Color.black)
                                //                                    }
                                //
                                //                                    Button {
                                //
                                //                                    } label: {
                                //                                        Image("eye-icon")
                                //                                            .resizable()
                                //                                            .scaledToFit()
                                //                                            .frame(width: 24, height: 24)
                                //                                    }
                                //                                }
                                //                                .padding(.horizontal, 10)
                                //                                .frame(height: 48)
                                //                                .background(Color.white)
                                //                                .cornerRadius(10)
                                
                                AuthPasswordTextFieldView(placeholder: .constant("Old password"), field: $oldPassword)
                                
                                Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                                    .font(.custom(Font.Medium, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                            
                            VStack(spacing: 20) {
                                //                                HStack {
                                //                                    VStack(alignment: .leading) {
                                //                                        Text("New password")
                                //                                            .font(.custom(Font.regular, size: 11))
                                //                                            .foregroundStyle(Color.theme.iconsColor)
                                //                                        SecureField("", text: $newPassword)
                                //                                            .font(.custom(Font.regular, size: 16))
                                //                                            .foregroundStyle(Color.black)
                                //                                    }
                                //
                                //                                    Button {
                                //
                                //                                    } label: {
                                //                                        Image("eye-icon")
                                //                                            .resizable()
                                //                                            .scaledToFit()
                                //                                            .frame(width: 24, height: 24)
                                //                                    }
                                //                                }
                                //                                .padding(.horizontal, 10)
                                //                                .frame(height: 48)
                                //                                .background(Color.white)
                                //                                .cornerRadius(10)
                                
                                AuthPasswordTextFieldView(placeholder: .constant("New password"), field: $newPassword)
                                
                                AuthButtonView(action: {
                                    changePasswordViewModel.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                                }, title: "SET NEW PASSWORD", background: Color.white, foreground: Color.black)
                                //                                .alert("Important message", isPresented: $changePasswordViewModel.isSuccess) {
                                //                                    Button("OK", role: .cancel) {presentationMode.wrappedValue.dismiss()}
                                //                                        }
                                
                                
                                
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
            .popup(isPresented: $changePasswordViewModel.showAlert) {
                FLToastAlert(image: .constant(""), message: $changePasswordViewModel.alertMessage)
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
            .onChange(of: changePasswordViewModel.isSuccess) { isSuccess in
                if isSuccess {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        presentationMode.wrappedValue.dismiss()
                        
                    }
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
    ChangePasswordView()
}
