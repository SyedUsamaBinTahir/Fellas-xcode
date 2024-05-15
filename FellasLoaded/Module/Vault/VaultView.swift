//
//  VaultView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct VaultView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            Text("Vault")
                .font(.custom(Font.semiBold, size: 24))
                .foregroundStyle(Color.white)
                .padding(.top, 60)
            ScrollView {
                VStack {
                    TabView {
                        ForEach(1...3, id: \.self) { images in
                            Image("vault-main-image")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(width: horizontalSizeClass == .regular ? 634 : UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? 634 : 390)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(.white)
                                .lineLimit(2)
                            Text("more")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(.white)
                        }
                        
                        HStack {
                            Text("5 days ago")
                                .font(.custom(Font.Medium, size: 14))
                                .foregroundStyle(.white)
                            Spacer()
                            HStack(spacing: 40) {
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image("share-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16, alignment: .center)
                                        Text("SHARE")
                                            .font(.custom(Font.bold, size: 14))
                                            .foregroundColor(Color.white)
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    HStack {
                                        Image("like-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16, alignment: .center)
                                        Text("12K")
                                            .font(.custom(Font.bold, size: 14))
                                            .foregroundColor(Color.white)
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                               Text("COMMENTS")
                                    .font(.custom(Font.semiBold, size: 14))
                                    .foregroundStyle(.white)
                                Text("217")
                                    .font(.custom(Font.regular, size: 14))
                                    .foregroundStyle(Color.theme.textGrayColor)
                            }
                            
                            HStack {
                                Image("profile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24, alignment: .center)
                                Text("I swear this pod turned into cal bragging to chip about things chip wasn’t invited to 😂 ")
                                    .font(.custom(Font.regular, size: 14))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Image("expand-arrow-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18, height: 18, alignment: .center)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.theme.tabbarColor)
                        .cornerRadius(10)
                        
                    }
                    .padding(horizontalSizeClass == .regular ? 0 : 10)
                }
                .frame(width: horizontalSizeClass == .regular ? 634 : nil)
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    VaultView()
}
