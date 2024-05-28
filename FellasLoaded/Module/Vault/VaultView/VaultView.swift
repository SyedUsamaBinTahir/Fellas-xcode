//
//  VaultView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct VaultView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var expandDescription = false
    @State private var redirectComment = false
    
    var body: some View {
        VStack {
            VaultHeaderView()
            
            ScrollView {
                ForEach(1...5, id: \.self) { _ in
                    VStack {
                        TabView {
                            ForEach(1...3, id: \.self) { images in
                                VaultMainImageView(images: .constant("vault-main-image"))
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: horizontalSizeClass == .regular ? 634 : UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? 634 : 390)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VaultDescriptionView(expandDescription: $expandDescription)
                            
                            VaultLikeAndShareButtonView(shareAction: {},
                                                        likeAction: {})
                            
                            VaultCommentsCardView(numberOfComments: .constant("217"), profileImage: .constant("profile"), comment: .constant("I swear this pod turned into cal bragging to chip about things chip wasn’t invited to 😂 "))
                            .onTapGesture {
                                redirectComment = true
                            }
                            .sheet(isPresented: $redirectComment, content: {
                                CommentView(dismissSheet: $redirectComment)
                            })
                            
                        }
                        .padding(horizontalSizeClass == .regular ? 0 : 10)
                    }
                    .frame(width: horizontalSizeClass == .regular ? 634 : nil)
                }
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
