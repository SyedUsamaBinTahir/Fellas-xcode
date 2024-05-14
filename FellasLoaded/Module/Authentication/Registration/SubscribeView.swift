//
//  SubscribeView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct SubscribeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var redirectToCreatepassword = false
    
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
                            Text("STEP 5 OF 5")
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
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if horizontalSizeClass == .regular {
                            Text("STEP 5 OF 5")
                                .font(.custom(Font.semiBold, size: 16))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        Image("app-image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 358, height: 152)
                        
                        Text("Gain unlimited access to all our content now")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                        
                        Text("You may cancel at anytime.")
                            .font(.custom(Font.regular, size: 16))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    Text("By signing up, you agree to our Terms of Service and Privacy Policy.")
                         .font(.custom(Font.regular, size: 14))
                         .foregroundStyle(Color.white)
                    
                    VStack(spacing: 20) {
                        FLButton(action: {
                        }, title: "£6.99 / MONTH", background: Color.white, foreground: Color.black)
                        
                        FLButton(action: {
                        }, title: "£69.99 / year", background: Color.white, foreground: Color.black)
                        
                        Text("12 Months at £5.83/month. Save over 15% with an annual subscription.")
                            .font(.custom(Font.regular, size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                                        
                    
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
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
    SubscribeView()
}
