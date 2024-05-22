//
//  ManageSubscriptionsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct ManageSubscriptionsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
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
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Image("app-image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 358, height: 152)
                        
                        Text("Gain unlimited access to all Fellas Loaded content now!")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                        
                        Text("You may cancel at anytime.")
                            .font(.custom(Font.regular, size: 16))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(spacing: 20) {
                        AuthButtonView(action: {
                        }, title: "£6.99 / MONTH", background: Color.white, foreground: Color.black)
                        
                        AuthButtonView(action: {
                        }, title: "£69.99 / year", background: Color.white, foreground: Color.black)
                        
                        Text("12 Months at £5.83/month. Save over 15% with an annual subscription.")
                            .font(.custom(Font.regular, size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.theme.textGrayColor)
                        
                        AuthButtonView(action: {
                            
                        }, title: "REDEEM SUBSCRIPTION", background: Color.theme.appGrayColor, foreground: .white)
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
    ManageSubscriptionsView()
}
