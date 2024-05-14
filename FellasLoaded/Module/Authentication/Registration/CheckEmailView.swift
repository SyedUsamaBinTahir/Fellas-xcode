//
//  CheckEmailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct CheckEmailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var code: String = ""
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
                    
                    if horizontalSizeClass != .regular {
                        HStack {
                            Text("STEP 3 OF 5")
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
                            Text("STEP 3 OF 5")
                                .font(.custom(Font.semiBold, size: 16))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        Text("Check your email")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                        
                        Text("We’ve sent an email to {{email}}, please follow the instructions in the email or type the code we sent you below so we can confirm your email.")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(spacing: 20) {
                        FLTextField(field: $code, title: "Code", placeHolder: "") {
                            
                        }
                        
                        Text("RESEND EMAIL")
                            .font(.custom(Font.bold, size: 16))
                            .foregroundStyle(Color.white)
                            .padding(.top)
                        
                        FLButton(action: {
                            redirectToDisplayNameAndImageView = true
                        }, title: "CONTINUE", background: Color.white, foreground: Color.black)
                    }
                    .padding(.top, 30)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToDisplayNameAndImageView) {
                    DisplayNameAndImageView()
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
    CheckEmailView()
}
