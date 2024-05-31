//
//  NewPasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct NewPasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Binding var code: String
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var retypePassword: String = ""
    @StateObject private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                    NewPasswordHeaderView()
                    
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text("Change your password")
                                .font(.custom(Font.semiBold, size: 32))
                                .foregroundStyle(Color.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading, spacing: 18) {
                                AuthPasswordTextFieldView(placeholder: .constant("Current password"), field: $currentPassword)
                                                                
                                Text("Use a minimum of 8 characters with a combination of uppercase & lowercase letters, numbers, and special characters.")
                                    .font(.custom(Font.Medium, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                            
                            VStack(spacing: 20) {
                                AuthPasswordTextFieldView(placeholder: .constant("Retype Password"), field: $currentPassword)
                                
                                AuthButtonView(action: {
                                    viewModel.showLoader = true
                                    viewModel.setNewPasswordRequest(code: code, password: currentPassword)
                                }, title: "CHANGE PASSWORD", background: Color.white, foreground: Color.black)
                            }
                        }
                    }
                    .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                    .padding(horizontalSizeClass == .regular ? 140 : 20)
                    
                    Spacer()
                }
                
                if viewModel.showLoader {
                    FLLoader()
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
    NewPasswordView( code: .constant(""))
}
