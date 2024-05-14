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
        NavigationStack {
            ZStack(alignment: horizontalSizeClass == .regular ? .center : .bottom) {
                if horizontalSizeClass == .regular {
                    Image("welcome-image")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                } else {
                    Image("welcome-image")
                        .resizable()
                        .scaledToFit()
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
                        FLButton(action: {
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
                        FLButton(action: {
                            redirectLogin = true
                        }, title: "LOG IN", background: Color.theme.appGrayColor, foreground: Color.white)
                        
                        FLButton(action: {
                            redirectExplore = true
                        }, title: "EXPLORE CONTENT", background: Color.theme.appGrayColor, foreground: Color.white)
                    }
                    .padding(.bottom)
                    .navigationDestination(isPresented: $redirectSignUp) {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    }
                    .navigationDestination(isPresented: $redirectLogin) {
                        EmailView().navigationBarBackButtonHidden(true)
                    }
                }
                .padding()
                .frame(width: horizontalSizeClass == .regular ? 440 : nil)
                
            }
            .edgesIgnoringSafeArea(.top)
            .background(
                LinearGradient(colors: [.black, Color.theme.appColor, .black], startPoint: .top, endPoint: .bottom)
            )
        }
    }
}

#Preview {
    WelcomeScreen()
}
