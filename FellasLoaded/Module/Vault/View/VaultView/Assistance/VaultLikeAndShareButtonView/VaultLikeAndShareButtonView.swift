//
//  VaultLikeAndDescriptionView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultLikeAndShareButtonView: View {
    let url = URL(string: "https://www.hackingwithswift.com")!
    @Binding var date: String
    @Binding var likeCount: String
    @Binding var likeStatus: Bool
    @State var shareAction: () -> Void
    @State var likeAction: () -> Void
    @State var dislikeAction: () -> Void
    
    var body: some View {
        HStack {
            Text(date)
                .font(.custom(Font.Medium, size: 14))
                .foregroundStyle(.white)
            Spacer()
            HStack(spacing: 40) {
                ShareLink(item: url) {
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
                
                if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                    Button (action: likeStatus ? likeAction : dislikeAction) {
                        HStack {
                            Image("like-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16, alignment: .center)
                            Text(likeCount)
                                .font(.custom(Font.bold, size: 14))
                                .foregroundColor(Color.white)
                        }
                    }
                }
            }
        }
    }
}
