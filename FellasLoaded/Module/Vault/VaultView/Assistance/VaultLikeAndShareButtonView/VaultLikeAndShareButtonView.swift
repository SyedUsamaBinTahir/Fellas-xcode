//
//  VaultLikeAndDescriptionView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultLikeAndShareButtonView: View {
    @State var shareAction: () -> Void
    @State var likeAction: () -> Void
    
    var body: some View {
        HStack {
            Text("5 days ago")
                .font(.custom(Font.Medium, size: 14))
                .foregroundStyle(.white)
            Spacer()
            HStack(spacing: 40) {
                Button (action: shareAction) {
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
                
                Button (action: likeAction) {
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
    }
}
