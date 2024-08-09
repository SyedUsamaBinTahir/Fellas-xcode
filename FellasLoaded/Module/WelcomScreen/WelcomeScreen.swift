//
//  WelcomeScreen.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct WelcomeScreen: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var redirectSignUp = false
    @State private var redirectLogin = false
    @State private var redirectExplore = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: horizontalSizeClass == .regular ? .center : .bottom) {
                if horizontalSizeClass == .regular {
                    Image("welcome-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                } else {
                    ZStack {
                        Image("welcome-image")
                            .resizable()
                            .clipped()
                        
                        Image("shadow-image")
                            .resizable()
                            .scaledToFill()
                    }
                }
                
                VStack(spacing: 30) {
                    Image("app-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 358, height: 152)
                    if horizontalSizeClass == .regular {
                        Text("Unlock feature-length specials, early podcast access, exclusive videos, and rewarding membership perks!")
                            .font(.custom(Font.semiBold, size: 28))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    
                    VStack(spacing: 14) {
                        AuthButtonView(action: {
                            redirectSignUp = true
                        }, title: "SIGN UP", background: Color.white, foreground: Color.black)
                        
                        Text("Start watching on Fellas Loaded for £6.99/month or £69.99/year. T&Cs apply.")
                            .font(.custom(Font.regular, size: 14))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.theme.textGrayColor)
                    }
                    .padding(.top)
                    
                    Rectangle()
                        .fill(Color.theme.appGrayColor.opacity(0.4))
                        .frame(maxWidth: .infinity, maxHeight: 2)
                    
                    VStack(spacing: 16) {
                        AuthButtonView(action: {
                            redirectLogin = true
                        }, title: "LOG IN", background: Color.theme.appGrayColor, foreground: Color.white)
                        
                        AuthButtonView(action: {
                            redirectExplore = true
                        }, title: "EXPLORE CONTENT", background: Color.theme.appGrayColor, foreground: Color.white)
                    }
                    .padding(.bottom)
                    
                    NavigationLink(destination: RegistrationView().navigationBarBackButtonHidden(true), isActive: $redirectSignUp) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: EmailView().navigationBarBackButtonHidden(true), isActive: $redirectLogin) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: Tabbar(), isActive: $redirectExplore) {
                        EmptyView()
                    }
                }
                .padding()
                .frame(width: horizontalSizeClass == .regular ? 440 : nil)
                
            }
            .edgesIgnoringSafeArea(.all)
            .background(
                LinearGradient(colors: [.black, Color.theme.appColor, .black], startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

#Preview {
    WelcomeScreen()
}
