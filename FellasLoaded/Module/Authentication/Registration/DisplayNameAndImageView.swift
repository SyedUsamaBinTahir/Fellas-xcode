//
//  DisplayNameAndImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct DisplayNameAndImageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var code: String = ""
    @State private var redirectToSubscribeView = false
    
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
                            Text("STEP 4 OF 5")
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
                
                VStack(alignment: .center, spacing: 30) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        if horizontalSizeClass == .regular {
                            Text("STEP 4 OF 5")
                                .font(.custom(Font.semiBold, size: 16))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        Text("Display name & image")
                            .font(.custom(Font.semiBold, size: 32))
                            .foregroundStyle(Color.white)
                        
                        Text("Display name is required, you can add a display picture later in your settings. Both display name and image will be visible to other users in comment sections.")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    Image("default-profile-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 108, height: 108, alignment: .center)
                    
                    VStack(spacing: 20) {
                        FLTextField(field: $code, title: "Display Name", placeHolder: "") {
                            
                        }
                        
                        FLButton(action: {
                            redirectToSubscribeView = true
                        }, title: "CREATE AN ACCOUNT", background: Color.white, foreground: Color.black)
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToSubscribeView) {
                    SubscribeView()
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
    DisplayNameAndImageView()
}
