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
    @State private var redirectManageSubscriptions = false
    @State private var dismissLogout = false
    @Binding var userEmail: String
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                SettingsHeaderView(title: .constant("Account"))
                
                VStack(alignment: .leading) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Account")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsNavigatorView(icon: nil, title: "Email", description: userEmail, forwardIcon: nil) { }
                                SettingsNavigatorView(icon: nil, title: "Change your password", description: "", forwardIcon: "chevron.right") { redirectChangePassword = true
                                }
                                SettingsNavigatorView(icon: nil, title: "Manage Subscription", description: "View details, or end subscription", forwardIcon: "chevron.right") { redirectManageSubscriptions = true }
                                SettingsNavigatorView(icon: nil, title: "Delete your account", description: "Permanently delete your account.", forwardIcon: "chevron.right") {
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
//            .navigationDestination(isPresented: $redirectDeleteAccount) {
//                DeleteAccountView().navigationBarBackButtonHidden(true)
//            }
//            .navigationDestination(isPresented: $redirectChangePassword) {
//                ChangePasswordView().navigationBarBackButtonHidden(true)
//            }
//            .navigationDestination(isPresented: $redirectManageSubscriptions) {
//                ManageSubscriptionsView().navigationBarBackButtonHidden(true)
//            }
            
            NavigationLink(isActive: $redirectDeleteAccount) {
                DeleteAccountView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $redirectChangePassword) {
                ChangePasswordView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $redirectManageSubscriptions) {
                ManageSubscriptionsView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }

        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AccountView(userEmail: .constant(""))
}
