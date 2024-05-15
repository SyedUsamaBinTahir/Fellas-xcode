//
//  AccountView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectDeleteAccount = false
    @State private var redirectChangePassword = false
    @State private var dismissLogout = false
    
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
                            Text("Account")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Account")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsNavigatorView(icon: nil, title: "Email", description: "user@gmail.com", forwardIcon: nil) { }
                                SettingsNavigatorView(icon: nil, title: "Change you password", description: "", forwardIcon: "chevron-icon") { redirectChangePassword = true
                                }
                                SettingsNavigatorView(icon: nil, title: "Manage Subscription", description: "View details, or end subscription", forwardIcon: "chevron-icon") { }
                                SettingsNavigatorView(icon: nil, title: "Delete your account", description: "Permanently delete your account.", forwardIcon: "chevron-icon") { 
                                    redirectDeleteAccount = true
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                Spacer()
            }
            .overlay {
                if dismissLogout {
                    LogOutView(cancelAction: { withAnimation(.easeInOut(duration: 0.2)) { dismissLogout = false } },
                               logoutAction: {})
                }
            }
            .navigationDestination(isPresented: $redirectDeleteAccount) {
                DeleteAccountView().navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $redirectChangePassword) {
                ChangePasswordView().navigationBarBackButtonHidden(true)
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AccountView()
}
