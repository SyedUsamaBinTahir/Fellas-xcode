//
//  EmailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct EmailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToPasswordView = false
    
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
                                .frame(width: 226, height: 98, alignment: .center)
                        }
                        
                        Text("Login in with your email?")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                    }
                    
                    VStack(spacing: 20) {
                        FLTextField(field: $email, title: "Email", placeHolder: "") {
                            
                        }
                        
                        FLButton(action: {
                            redirectToPasswordView = true
                        }, title: "CONTINUE", background: Color.white, foreground: Color.black)
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToPasswordView) {
                    PasswordView()
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
    EmailView()
}
