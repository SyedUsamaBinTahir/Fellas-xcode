//
//  DeleteAccountView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI
import ExytePopupView

struct DeleteAccountView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var password: String = ""
    @State private var redirectToDisplayNameAndImageView = false
    @StateObject var deleteAccountVm = DeleteAccountViewModel()
    @State var suretyCheck: Bool = false
    @State var awareCheck: Bool = false
    let savePassword = UserDefaults.standard.string(forKey: FLUserDefaultKeys.savePassword.rawValue)
    @State var showWelcomeScreen: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    ZStack {
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
                    }
                    .padding(.top, 50)
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Delete your account?")
                                .font(.custom(Font.semiBold, size: 32))
                                .foregroundStyle(Color.white)
                            
                            Text("By deleting your account, all your data will be erased, and your account will be permanently deleted. This action cannot be reversed.")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.textGray)
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading, spacing: 10) {
                                //                                HStack {
                                //                                    VStack(alignment: .leading) {
                                //                                        Text("Password")
                                //                                            .font(.custom(Font.regular, size: 11))
                                //                                            .foregroundStyle(Color.theme.iconsColor)
                                //                                        SecureField("", text: $password)
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
                                
                                AuthPasswordTextFieldView(placeholder: .constant("password"), field: $password)
                            }
                            
                            HStack(spacing: 16) {
                                Button(action: {
                                    suretyCheck.toggle()
                                },
                                       label: {
                                    Image(systemName: "checkmark.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(suretyCheck ? Color.white : Color(.systemGray4))
                                })
                                
                                
                                Text("I am sure I want to delete my account.")
                                    .font(.custom(Font.regular, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                            
                            HStack(spacing: 16) {
                                Button(action: {
                                    awareCheck.toggle()
                                },
                                       label: {
                                    Image(systemName: "checkmark.rectangle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(awareCheck ? Color.white : Color(.systemGray4))
                                })
                                
                                Text("I am aware that deleting my account will remove all my data.")
                                    .font(.custom(Font.regular, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        if awareCheck && suretyCheck {
                            AuthButtonView(action: {
                                if password == savePassword {
                                    deleteAccountVm.deleteAccount()
                                    FLUserJourney.shared.logoutOccured()
                                    
                                } else {
                                    print("PASSWORD NOT MATCHED")
                                }
                                
                                //                            if deleteAccountVm.isSuccess {
                                //                                UserDefaults.standard.removeObject(forKey: FLUserDefaultKeys.savePassword.rawValue)
                                //                            }
                                
                                //                        redirectToDisplayNameAndImageView = true
                                
                            }, title: "DELETE MY ACCOUNT", background: Color.white, foreground: Color.black)
                            .padding(.bottom, 30)
                        } else {
                            AuthButtonView(action: {}, title: "DELETE MY ACCOUNT", background: Color.white.opacity(0.5), foreground: Color.black)
                                .padding(.bottom, 30)
                                .disabled(true)
                        }
                        
                        
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
            
            .popup(isPresented: $deleteAccountVm.showAlert) {
                FLToastAlert(image: .constant(""), message: $deleteAccountVm.alertMessage)
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
            .onChange(of: deleteAccountVm.isSuccess) { newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showWelcomeScreen = true
                        }
                    }
                }
            }
            
            if showWelcomeScreen {
                WelcomeScreen()
                    .transition(.move(edge: .bottom))
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
