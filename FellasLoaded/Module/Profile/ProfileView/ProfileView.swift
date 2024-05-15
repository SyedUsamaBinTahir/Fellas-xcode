//
//  ProfileView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var redirectSettings = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    redirectSettings = true
                }, label: {
                    Image("settings-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                })
            }
            .padding()
            .padding(.top, 30)
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack(alignment: .center) {
                        Image("default-profile-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 108, height: 108, alignment: .center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .overlay {
                                Circle()
                                    .stroke(Color.white)
                            }
                        
                        Text("Title")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Gain unlimited access to all our content now!")
                            .font(.custom(Font.semiBold, size: 20))
                            .foregroundStyle(.white)
                        Text("You may cancel at anytime.")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                        Button {
                            
                        } label: {
                            Text("BECOME A MEMBER")
                                .font(.custom(Font.bold, size: 14))
                                .padding(10)
                                .foregroundStyle(.white)
                                .background(Color.theme.appRedColor)
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.top)
                    
                    VStack(spacing: 14) {
                        SettingsNavigatorView(icon: "download", title: "Downloads", description: nil, forwardIcon: "chevron-icon") {
                            
                        }
                        SettingsNavigatorView(icon: "watchlist-icon", title: "Watchlist ", description: nil, forwardIcon: "chevron-icon") {
                            
                        }
                        
                        Button {
                            
                        } label: {
                            VStack {
                                HStack(spacing: 20) {
                                    Image("confession-box")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Confession box")
                                            .font(.custom(Font.semiBold, size: 16))
                                        Text("We’re closed so note it down, and come back when we’re open. We’ll notify you when we’re back up.")
                                            .font(.custom(Font.Medium, size: 14))
                                            .foregroundStyle(Color.theme.textGrayColor)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                    
                                    Image("chevron-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                }
                                .foregroundStyle(Color.gray)
                                
                                Rectangle()
                                    .fill(Color.theme.appGrayColor.opacity(0.4))
                                    .frame(maxWidth: .infinity, maxHeight: 2)
                                    .padding(.top)
                            }
                        }
                    }
                    .padding(.top)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                .navigationDestination(isPresented: $redirectSettings) {
                    SettingsView().navigationBarBackButtonHidden(true)
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
    ProfileView()
}
