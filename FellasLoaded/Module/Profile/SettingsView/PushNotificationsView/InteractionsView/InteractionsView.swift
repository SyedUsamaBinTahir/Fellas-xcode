//
//  InteractionsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct InteractionsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var videosRepliesCommentsToggle = false
    @State private var videosCommentLikesToggel = false
    @State private var vaultRepliesCommentsToggle = false
    @State private var valutCommentLikesToggel = false
    
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
                            Text("Interactions")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Interactions")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(alignment: .leading ,spacing: 26) {
                                Text("Videos")
                                    .font(.custom(Font.semiBold, size: 16))
                                    .foregroundStyle(Color.theme.textGrayColor)
                                SettingsToggleButtonView(icon: nil, title: "Confession box", description: "Notify me when the confession box is opened.", toggle: $videosRepliesCommentsToggle)
                                SettingsToggleButtonView(icon: nil, title: "App updates", description: "Notify me when a new app updates is released.", toggle: $videosCommentLikesToggel)
                                
                                Text("Vault")
                                    .font(.custom(Font.semiBold, size: 16))
                                    .foregroundStyle(Color.theme.textGrayColor)
                                SettingsToggleButtonView(icon: nil, title: "Confession box", description: "Notify me when the confession box is opened.", toggle: $vaultRepliesCommentsToggle)
                                SettingsToggleButtonView(icon: nil, title: "App updates", description: "Notify me when a new app updates is released.", toggle: $valutCommentLikesToggel)
                            }
                            .padding(.top)
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
    InteractionsView()
}
